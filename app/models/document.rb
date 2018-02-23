# == Schema Information
#
# Table name: documents
#
#  id          :integer          not null, primary key
#  external_id :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  source_id   :integer
#  file_url    :string
#  imported    :boolean          default(FALSE)
#
# Indexes
#
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

    checked = 0
    created = 0
    total_lines = lines.count
    start_time = DateTime.now

    snp_ids = []

    lines.each do |line|
      next if line.blank?

      if line.start_with? '#'
        if header.blank? && line =~ /#\s+(\w+\t){1,5}\w+/
          header = line.split(/#\s+/).last.split("\t").map(&:strip)
        end

        next
      end

      data = line.split("\t").map(&:strip)

      if header.blank? && data[0] == 'rsid'
        header = data
        next
      end

      params = header.zip(data).to_h.slice(*whitelist)

      snp = Snp.where(rsid: params['rsid']).first_or_create do |snp|
        params.each do |key, value|
          snp.send("#{key}=", value)
        end

        created += 1
      end

      snp.sources += [self.source]

      checked += 1

      if checked % 1000 == 0
        amount_done = checked/total_lines.to_f
        percent_done = (100 * amount_done).round(2)

        time_elapsed = ((DateTime.now - start_time).to_f * 1.day).round(2)
        time_remaining = (time_elapsed / amount_done - time_elapsed).round(2)

        puts "\tDocument ID #{self.id}: ~#{percent_done}% done (#{time_elapsed}s elapsed, ~#{time_remaining}s remaining)"
      end
    end

    puts "Processed document ID #{self.id}: #{created} new SNPs created (#{checked} in document, #{total_lines} lines)"

    self.update(imported: true)
  end

  def as_json(_opts={})
    {
        id: self.id,
        source: self.source.to_s,
        file_url: self.file_url,
        external_id: self.external_id,
        imported: self.imported
    }
  end

end
