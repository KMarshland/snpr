class CreateGenomicContexts < ActiveRecord::Migration[5.1]
  def change
    create_table :genomic_contexts do |t|
      t.belongs_to :snp, foreign_key: true
      t.string :gene
      t.integer :distance

      t.timestamps
    end
  end
end
