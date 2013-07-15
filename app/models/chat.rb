class Chat < ActiveRecord::Base
  # attr_accessible :title, :body
  attr_accessible :sender_id, :receiver_id, :chat, :created_at
  belongs_to :sender, :class_name => "user", :foreign_key => "sender_id"
  belongs_to :receiver, :class_name => "user", :foreign_key => "receiver_id"
end
