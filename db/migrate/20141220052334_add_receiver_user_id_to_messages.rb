class AddReceiverUserIdToMessages < ActiveRecord::Migration
  def change
    add_column :messages, :receiver_user_id, :integer
  end
end
