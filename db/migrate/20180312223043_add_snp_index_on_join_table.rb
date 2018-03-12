class AddSnpIndexOnJoinTable < ActiveRecord::Migration[5.1]
  def change
    add_index :snps_sources, :snp_id
  end
end
