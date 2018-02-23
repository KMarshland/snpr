class AddProcessingStartTimeToDocuments < ActiveRecord::Migration[5.1]
  def change
    add_column :documents, :processing_start_time, :datetime
  end
end
