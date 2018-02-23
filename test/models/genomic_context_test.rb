# == Schema Information
#
# Table name: genomic_contexts
#
#  id         :integer          not null, primary key
#  snp_id     :integer
#  gene       :string
#  distance   :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_genomic_contexts_on_snp_id  (snp_id)
#
# Foreign Keys
#
#  fk_rails_...  (snp_id => snps.id)
#

require 'test_helper'

class GenomicContextTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
