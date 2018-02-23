class RemoveCompoundSnpIndicesOnJoinTable < ActiveRecord::Migration[5.1]
  def change
    remove_index :snps_sources, [:snp_id, :source_id]
    remove_index :snps_sources, [:source_id, :snp_id]
  end
end
