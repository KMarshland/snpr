class AddSourceToDocuments < ActiveRecord::Migration[5.1]
  def change
    remove_column :documents, :source
    add_reference :documents, :source, foreign_key: true
  end
end
