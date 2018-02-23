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

  end

end
