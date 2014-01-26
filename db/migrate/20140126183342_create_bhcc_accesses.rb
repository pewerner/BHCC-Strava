class CreateBhccAccesses < ActiveRecord::Migration
  def change
    create_table :bhcc_accesses do |t|
      t.string :token

      t.timestamps
    end
  end
end
