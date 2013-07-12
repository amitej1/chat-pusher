class ChatsController < ApplicationController
	def index
		@users = User.all
	end	

	def show
			user = User.find(params[:id])
   @user = user
   
   @chats = Chat.where(("sender_id = '#{current_user[:id]}' AND receiver_id = '#{user[:id]}') OR (receiver_id = '#{current_user[:id]}' AND sender_id = '#{user[:id]}'"))
	end
end	
