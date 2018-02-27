# == Schema Information
#
# Table name: diseases_snps
#
#  snp_id     :integer          not null
#  disease_id :integer          not null
#

class DiseasesSnp < ApplicationRecord

  def self.bulk_insert(disease_id, snp_ids)

    return if snp_ids.empty?

    raise 'Invalid disease id' unless disease_id.is_a? Integer

    values = snp_ids.map do |snp_id|
      raise 'Invalid snp id' unless snp_id.is_a? Integer

      "(#{snp_id},#{disease_id})"
    end

    query = "INSERT INTO diseases_snps (snp_id, disease_id) VALUES #{values.join(',')}"
    ActiveRecord::Base.connection.execute(query)
  end

end
