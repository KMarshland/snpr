class AddErroroneousToDocuments < ActiveRecord::Migration[5.1]
  def change
    add_column :documents, :erroneous, :boolean, default: false
    add_index :documents, :erroneous
  end
end
