class AddColumnsToChat < ActiveRecord::Migration
  def change
  	add_column :chats, :sender_id, :integer
  	add_column :chats, :receiver_id, :integer
  	add_column :chats, :chat, :text
  end
end
