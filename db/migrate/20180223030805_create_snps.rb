class CreateSnps < ActiveRecord::Migration[5.1]
  def change
    create_table :snps do |t|
      t.string :rsid
      t.string :chromosome
      t.integer :position
      t.string :allele1
      t.string :allele2
      t.boolean :checked_gwas
      t.string :functional_class

      t.timestamps
    end
    add_index :snps, :rsid, unique: true
    add_index :snps, :checked_gwas
  end
end
