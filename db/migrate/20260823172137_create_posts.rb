class CreatePosts < ActiveRecord::Migration[8.1]
  def change
    create_table :posts do |t|
      t.references :user, null: false, foreign_key: true
      t.text :body
      t.string :link_url

      t.timestamps
    end

    add_index :posts, :created_at
  end
end
