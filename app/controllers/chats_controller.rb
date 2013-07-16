class ChatsController < ApplicationController
	def index
		@users = User.all
	end	

	def show
			user = User.find(params[:id])
   @user = user
   
   @chats = Chat.where(("sender_id = '#{current_user[:id]}' AND receiver_id = '#{user[:id]}') OR (receiver_id = '#{current_user[:id]}' AND sender_id = '#{user[:id]}'"))
	end

	def create
    chat = Chat.new(params[:chat])
     @user = User.find(params[:chat][:receiver_id])
    chat.sender_id = current_user.id
    if chat.save
      flash[:notice] = "you created a message"
      redirect_to '/'
      
      # Send a Pusher notification
      Pusher['private-'+params[:chat][:receiver_id]+params[:chat][:sender_id]].trigger('chat', {:from => current_user.id, :chat => chat.chat})
      Pusher['private-'+params[:chat][:sender_id]+params[:chat][:receiver_id]].trigger('chat', {:from => current_user.id, :chat => chat.chat})
    
    else
      @user = User.find(params[:chat][:receiver_id])
      render :action => 'users/show'
    end
  end
end	
