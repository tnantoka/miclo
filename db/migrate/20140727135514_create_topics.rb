class CreateTopics < ActiveRecord::Migration
  def change
    create_table :topics do |t|
      t.references :user, index: true
      t.integer :sequential_id, null: false

      t.timestamps
    end

    add_index :topics, [:user_id, :sequential_id], unique: true
  end
end
