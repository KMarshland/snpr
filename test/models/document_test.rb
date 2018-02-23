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

require 'test_helper'

class DocumentTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
