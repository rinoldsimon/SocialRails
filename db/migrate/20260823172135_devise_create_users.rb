# frozen_string_literal: true

class DeviseCreateUsers < ActiveRecord::Migration[8.1]
  def change
    create_table :users do |t|
      t.string :email, null: false, default: ""
      t.string :encrypted_password, null: false, default: ""
      t.string :reset_password_token
      t.datetime :reset_password_sent_at
      t.datetime :remember_created_at
      t.string :name, null: false
      t.string :username, null: false
      t.text :bio
      t.string :github_username
      t.string :provider
      t.string :uid

      t.timestamps null: false
    end

    add_index :users, :email, unique: true
    add_index :users, :reset_password_token, unique: true
    add_index :users, :username, unique: true
    add_index :users, [ :provider, :uid ], unique: true, where: "uid IS NOT NULL"
  end
end
