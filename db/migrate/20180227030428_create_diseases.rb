class CreateDiseases < ActiveRecord::Migration[5.1]
  def change
    create_table :diseases do |t|
      t.string :name
      t.string :short_form
      t.boolean :checked_gwas, default: false

      t.timestamps
    end
  end
end
