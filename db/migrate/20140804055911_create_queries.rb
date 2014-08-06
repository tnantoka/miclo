class CreateQueries < ActiveRecord::Migration
  def change
    create_table :queries do |t|
      t.string :text, null: false, default: ''
      t.references :user, index: true

      t.timestamps
    end
  end
end
