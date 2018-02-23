# == Schema Information
#
# Table name: documents
#
#  id          :integer          not null, primary key
#  external_id :string
#  source      :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
# Indexes
#
#  index_documents_on_external_id  (external_id) UNIQUE
#  index_documents_on_source       (source)
#

class Document < ApplicationRecord

  validates :external_id, presence: true, uniqueness: true
  validates :source, presence: true

  def self.sources
    %i[
        23andme
        ancestry
        ftdna-illumina
    ]
  end

  validates :status, inclusion: { in: Document.sources.map(&:to_s),
                                  message: '%<value> is not a valid source' }

end
