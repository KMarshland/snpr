class IndexSnpIdAndSourceIdOnSnpsSource < ActiveRecord::Migration[5.1]
  def change

    add_index :snps_sources, :snp_id
    add_index :snps_sources, :source_id

  end
end
