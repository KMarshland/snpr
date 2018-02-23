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

  def self.bulk_insert(source_id, snp_ids)

    return if snp_ids.empty?

    raise 'Invalid source id' unless source_id.is_a? Integer

    values = snp_ids.map do |snp_id|
      raise 'Invalid snp id' unless snp_id.is_a? Integer

      "(#{snp_id},#{source_id})"
    end

    query = "INSERT INTO snps_sources (snp_id, source_id) VALUES #{values.join(',')}"
    ActiveRecord::Base.connection.execute(query)
  end

end
