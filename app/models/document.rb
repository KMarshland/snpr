# == Schema Information
#
# Table name: documents
#
#  id                    :integer          not null, primary key
#  external_id           :string
#  created_at            :datetime         not null
#  updated_at            :datetime         not null
#  source_id             :integer
#  file_url              :string
#  imported              :boolean          default(FALSE)
#  processing_start_time :datetime
#  erroneous             :boolean          default(FALSE)
#
# Indexes
#
#  index_documents_on_erroneous    (erroneous)
#  index_documents_on_external_id  (external_id) UNIQUE
#  index_documents_on_imported     (imported)
#  index_documents_on_source_id    (source_id)
#
# Foreign Keys
#
#  fk_rails_...  (source_id => sources.id)
#

class Document < ApplicationRecord

  belongs_to :source

  validates :external_id, presence: true, uniqueness: true
  validates :source, presence: true
  validates :file_url, presence: true

  def import

    if self.processing_start_time.present? && self.processing_start_time > 1.hour.ago
      puts "Already processing document ID #{self.id}"
      return
    else
      self.update(processing_start_time: DateTime.now)
    end

    cache_location = Rails.root.join('tmp', 'dataset-' + self.file_url.gsub(/\W/, '-') + '.cached')

    if File.exist? cache_location
      content = File.read cache_location

      puts "Document ID #{self.id}: read from cache"
    else
      puts "Document ID #{self.id}: downloading #{self.file_url}"

      response = HTTP.get(self.file_url)

      raise "Invalid response code #{response.code}" unless response.code.to_i == 200

      content = response.body.to_s
      File.write(cache_location, content)

      puts "Document ID #{self.id}: downloaded #{self.file_url}"
    end

    lines = content.split("\n")

    puts "Document ID #{self.id}: processing..."

    header = nil
    whitelist = %w(rsid chromosome position allele1 allele2)
    source_name = self.source.name

    checked = 0
    created = 0
    total_lines = lines.count
    start_time = DateTime.now

    snp_ids = Set.new
    existing_snps = SnpsSource.where(source_id: self.source_id).pluck(:snp_id).to_set
    rsids = Snp.pluck(:rsid, :id).to_h

    to_create = []

    flush = -> {

      snp_ids += Snp.bulk_insert(to_create)

      created += to_create.length
      to_create = []

      snp_ids -= existing_snps

      SnpsSource.bulk_insert(self.source_id, snp_ids)

      snp_ids = Set.new
    }

    batch_size = 10000
    debug_size = batch_size

    lines.each do |line|
      next if line.blank?

      if line.start_with? '#'
        if header.blank? && line =~ /#\s+(\w+(\t| {2,})){1,5}\w+/
          header = line.split(/#\s+/).last.split(/\t| {2,}/).map(&:strip)
        end

        next
      end

      data = line.split(/\t|,/).map do |datum|
        datum.strip.gsub(/\A"|"\Z/, '')
      end

      if header.blank? && data[0].downcase == 'rsid'
        header = data.map(&:downcase)
        next
      end

      if header.blank? && data[0] =~ /\Ars\d+\Z/ && source_name == '23andme'
        header = %w(rsid chromosome position genotype)
      end

      params = header.zip(data).to_h.slice(*whitelist)

      next if params['rsid'].downcase == 'rsid'
      next unless params['rsid'] =~ /rs\d+/

      id = rsids[params['rsid']]

      if id
        snp_ids << id
      else
        to_create << params
      end

      checked += 1

      if checked % debug_size == 0
        amount_done = checked/total_lines.to_f
        percent_done = (100 * amount_done).round(2)

        time_elapsed = ((DateTime.now - start_time).to_f * 1.day).round(2)
        time_remaining = (time_elapsed / amount_done - time_elapsed)
        eta = DateTime.now + time_remaining.seconds

        puts "\tDocument ID #{self.id}: ~#{percent_done}% done (#{time_elapsed}s elapsed, ETA #{eta.strftime('%-I:%M:%S %P')})"
      end

      if checked % batch_size == 0
        flush[]
      end
    end

    flush[]

    time_elapsed = ((DateTime.now - start_time).to_f * 1.day).round(2)
    puts "Processed document ID #{self.id}: #{created} new SNPs created (#{checked} in document, #{total_lines} lines, #{time_elapsed}s elapsed)"

    self.update(
        imported: true,
        processing_start_time: nil
    )
  rescue  Encoding::UndefinedConversionError
    puts 'Encoding error; deleting cache'

    File.delete(cache_location) if defined? cache_location

    self.update(erroneous: true, processing_start_time: nil)

  rescue Exception => e
    self.update(processing_start_time: nil)

    raise e
  end

  def as_json(_opts={})
    {
        id: self.id,
        source_id: self.source_id,
        file_url: self.file_url,
        external_id: self.external_id,
        imported: self.imported
    }
  end

end
