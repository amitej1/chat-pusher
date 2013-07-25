# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
Privatechat::Application.initialize!

 require 'pusher'
  Pusher.logger = Rails.logger
  Pusher.app_id = '50255'
  Pusher.key    = 'aaf22ec58ddbff4643d5'
  Pusher.secret = '04673d7bb7f205cf86b9'

  PUSHER_JS_DOMAIN = 'http://js.pusher.com'
PUSHER_SOCKET_HOST = 'ws.pusherapp.com'
PUSHER_WS_PORT = 80