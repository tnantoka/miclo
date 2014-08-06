class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :username, null: false
      t.integer :locale, null: false, default: 0
      t.text :image

      t.timestamps
    end

    add_index :users, :username, unique: true
  end
end
