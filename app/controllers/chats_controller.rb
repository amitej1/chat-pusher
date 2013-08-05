class ChatsController < ApplicationController
	def index
		if user_signed_in?
    user = current_user
          
        #Pusher['presence-public-101'].trigger('online',{:email => user.email, :id => user.id, :updated => user.updated_at})
      end
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
    @sender = current_user
    if chat.save
      flash[:notice] = "you created a message"
      redirect_to '/'
      
      # Send a Pusher notification
      Pusher['private-'+params[:chat][:receiver_id]+params[:chat][:sender_id]].trigger('chat1', {:from => current_user.email, :chat => chat.chat})
      #Pusher['private-'+params[:chat][:receiver_id]+'null'].trigger('popup', {:from => current_user.email, :chat => chat.chat, :id => current_user.id})
      Pusher['normal-'+params[:chat][:receiver_id]].trigger('popup', {:from => current_user.email, :chat => chat.chat, :id => current_user.id})
      Pusher['private-'+params[:chat][:sender_id]+params[:chat][:receiver_id]].trigger('chat', {:from => current_user.email, :chat => chat.chat})
      #Pusher['presence-public-101'].trigger('incoming', {:from => current_user.email})
    else
      @user = User.find(params[:chat][:receiver_id])
      render :action => 'users/show'
    end
  end
end	
