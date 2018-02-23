class CreateJoinTableSnpsSources < ActiveRecord::Migration[5.1]
  def change
    create_join_table :snps, :sources do |t|
      t.index [:snp_id, :source_id]
      t.index [:source_id, :snp_id]
    end
  end
end
