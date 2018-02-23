class RemoveSnpIndexOnJoinTable < ActiveRecord::Migration[5.1]
  def change
    remove_index :snps_sources, :snp_id
  end
end
