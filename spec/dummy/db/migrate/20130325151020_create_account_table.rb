class CreateAccountTable < ActiveRecord::Migration
  def up
    create_table :accounts do |t|
      t.string   :name

      t.timestamps
    end
  end

  def down
    drop_table :accounts
  end
end
