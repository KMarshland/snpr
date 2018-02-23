class RemoveGwasIndexOnSnps < ActiveRecord::Migration[5.1]
  def change
    remove_index :snps, :checked_gwas
  end
end
