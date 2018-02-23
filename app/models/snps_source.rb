# == Schema Information
#
# Table name: snps_sources
#
#  snp_id    :integer          not null
#  source_id :integer          not null
#
# Indexes
#
#  index_snps_sources_on_source_id  (source_id)
#

class SnpsSource < ApplicationRecord

end
