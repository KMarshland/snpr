# == Schema Information
#
# Table name: snps
#
#  id               :integer          not null, primary key
#  rsid             :string
#  chromosome       :string
#  position         :integer
#  allele1          :string
#  allele2          :string
#  checked_gwas     :boolean          default(FALSE)
#  functional_class :string
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#
# Indexes
#
#  index_snps_on_checked_gwas  (checked_gwas)
#  index_snps_on_rsid          (rsid) UNIQUE
#

require 'test_helper'

class SnpTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
