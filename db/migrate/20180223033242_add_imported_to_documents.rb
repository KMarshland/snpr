class AddImportedToDocuments < ActiveRecord::Migration[5.1]
  def change
    add_column :documents, :imported, :boolean, default: false
    add_index :documents, :imported
  end
end
