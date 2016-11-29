class CreateAuthentications < ActiveRecord::Migration[5.0]
  def change
    create_table :authentications do |t|
      t.integer :user_id
      t.string :provider
      t.string :uid
      t.string :token
      t.string :secret

      t.timestamps
    end
    add_index :authentications, [:user_id, :provider, :uid, :token, :secret], unique: true, name: 'omniauth_index'
  end
end
