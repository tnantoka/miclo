class CreateIdentities < ActiveRecord::Migration
  def change
    create_table :identities do |t|
      t.string :uid, null: false
      t.string :provider, null: false, default: ''
      t.references :user, index: true
      t.text :raw

      t.timestamps
    end

    add_index :identities, [:uid, :provider], unique: true
  end
end
