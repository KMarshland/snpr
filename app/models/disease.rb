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
end
