class CreateGchats < ActiveRecord::Migration
  def change
    create_table :gchats do |t|
      t.text :body
      t.references :user, index: true

      t.timestamps
    end
  end
end
