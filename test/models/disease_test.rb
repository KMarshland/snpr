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

require 'test_helper'

class DiseaseTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
