class DropDataTable < ActiveRecord::Migration
  def up
    drop_table :ride_data
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
