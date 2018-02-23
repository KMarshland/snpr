class CreateDocuments < ActiveRecord::Migration[5.1]
  def change
    create_table :documents do |t|
      t.string :external_id
      t.string :source

      t.timestamps
    end
    add_index :documents, :external_id, unique: true
    add_index :documents, :source
  end
end
