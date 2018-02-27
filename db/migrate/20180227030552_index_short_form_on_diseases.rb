class IndexShortFormOnDiseases < ActiveRecord::Migration[5.1]
  def change
    add_index :diseases, :short_form, unique: true
  end
end
