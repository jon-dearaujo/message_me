class ApplicationController < ActionController::Base

  before_action :require_user, only: [:index]
  helper_method :current_user, :logged_in?

  def index
    @message = Message.new
    @messages = Message.custom_display
  end

  def create_message
    @message = Message.new body: params[:message][:body], user: current_user
    if @message.save
      ActionCable.server.broadcast "chatroom_channel", mod_message: message_render(@message)
    end
  end

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def logged_in?
    !!current_user
  end

  def require_user
    if !logged_in?
      flash[:error] = "You must be logged in to perform that action"
      redirect_to signin_path
    end
  end

  def message_render(message)
    render(partial: 'messages/message', locals: {message: message})
  end
end
