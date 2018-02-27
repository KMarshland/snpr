class CreateJoinTableSnpsDiseases < ActiveRecord::Migration[5.1]
  def change
    create_join_table :snps, :diseases do |t|
      # t.index [:snp_id, :disease_id]
      # t.index [:disease_id, :snp_id]
    end
  end
end
