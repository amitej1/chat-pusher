class PusherController < ApplicationController
  protect_from_forgery :except => :auth # stop rails CSRF protection for this action
  
  def auth
    if current_user
      response = Pusher[params[:channel_name]].authenticate(params[:socket_id],
      :user_id => current_user.id,
     	:user_info => { # => optional - for example
          
          :email => current_user.email
        })
      render :json => response
    else
      render :text => "Not authorized", :status => '403'
    end
  end

   def typing_status
    #debugger
    if params[:status] != nil
     #@user = User.find(params[:chat][:receiver_id])
      user = params[:user]
      user1 = params[:current_user]
      user_mail = params[:user_mail]
      #payload = { :user => user.attributes, :status => params[:status] }
      #Pusher["presence-" + chat.channel].trigger('typing_status', payload)
      Pusher['private-'+user+user1].trigger('typing_status', {:from => user_mail, :id => user1, :status => params[:status]})
    end
    
  end
end
