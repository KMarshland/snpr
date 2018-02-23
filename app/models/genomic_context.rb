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

class GenomicContext < ApplicationRecord
  belongs_to :snp

  validates :gene, presence: true
  validates :distance, presence: true

end
