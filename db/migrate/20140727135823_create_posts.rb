class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.text :content, null: false
      t.references :user, index: true
      t.references :topic, index: true
      t.integer :sequential_id, null: false

      t.timestamps
    end

    add_index :posts, [:user_id, :topic_id, :sequential_id], unique: true
  end
end
