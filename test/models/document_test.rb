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

require 'test_helper'

class DocumentTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
