# == Schema Information
#
# Table name: diseases
#
#  id           :integer          not null, primary key
#  name         :string
#  short_form   :string
#  checked_gwas :boolean          default(FALSE)
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#
# Indexes
#
#  index_diseases_on_short_form  (short_form) UNIQUE
#
require Rails.root.join('lib', 'gwas', 'gwas.rb')

class Disease < ApplicationRecord

  has_and_belongs_to_many :snps

  def as_json(opts={})
    {
        id: self.id,
        name: self.name,
        short_form: self.short_form,
        snps: opts[:use_length] ? self.snps.length : self.snps.count,
        created_at: self.created_at,
        updated_at: self.updated_at
    }
  end

  def as_short_json
    {
        id: self.id,
        name: self.name,
        short_form: self.short_form
    }
  end

  def pull_snps
    client = GWAS::Client.new

    response = client.snps_with_efo_trait self.name

    snps = response['_embedded']['singleNucleotidePolymorphisms']

    snps.map! do |snp|
      next nil if snp['locations'][0].blank?

      {
          rsid: snp['rsId'],
          chromosome: snp['locations'][0]['chromosomeName'],
          position: snp['locations'][0]['chromosomePosition'],
          functional_class: snp['functionalClass'],
          checked_gwas: true
      }.stringify_keys
    end

    snps.select!(&:present?)

    rsids = snps.map do |snp|
      snp['rsid']
    end

    rsids -= self.snps.pluck(:rsid)

    created = Snp.bulk_insert snps, keys: %w(rsid chromosome position functional_class checked_gwas)

    ids = Snp.where(rsid: rsids).pluck(:id)
    DiseasesSnp.bulk_insert self.id, ids

    self.update(checked_gwas: true)

    puts "Inserted #{created.count} SNPs (#{ids.count} linked out of #{snps.count}) for #{self.name} (disease id #{self.id})"
  rescue Exception => e
    puts "Error on #{self.name} (disease id #{self.id})"
    puts response if defined? response
    raise e
  end

  def self.pull_from_gwas
    client = GWAS::Client.new

    page = 0
    total_pages = 1

    inserted = 0

    until page >= total_pages
      response = client.list_efo_traits page: page

      total_pages = response['page']['totalPages']

      traits = response['_embedded']['efoTraits']

      traits.map! do |trait|
        {
            name: trait['trait'],
            short_form: trait['shortForm']
        }
      end

      ids = self.bulk_insert traits

      inserted += ids.count

      puts "Inserted #{inserted} so far (page #{page})"

      page += 1
    end
  end

  def self.bulk_insert(params)

    return [] if params.empty?

    keys = %i(name short_form)

    now = DateTime.now.to_s

    values = params.map do |param|

      "(#{keys.map{|key|
        value = param[key]

        "'#{value.gsub(/["'`]/, '')}'"
      }.join(',')},'#{now}','#{now}')"
    end

    query = "INSERT INTO diseases (#{keys.join(',')},created_at,updated_at) VALUES #{values.join(',')} ON CONFLICT (short_form) DO NOTHING RETURNING id"

    result = ActiveRecord::Base.connection.execute(query)

    result.values.flatten
  end

  def self.as_short_json
    all.map(&:as_short_json)
  end

end
