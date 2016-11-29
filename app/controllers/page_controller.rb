class PageController < ApplicationController
  # before_action :authenticate_user!
  # def callback
  #   response = Instagram.get_access_token(param[:code], redirect_uri: ENV['REDIRECT_URI'])
  #   session[:access_token] = response.access_token
  #   redirect_to root_path
  # end




  def dashboard
    return unless current_user && current_user.instagram_authenticated?
      @tags = current_user.instagram_tags
      @entry = Entry.new
      @display = Display.new
      @displays = Display.all

  end


end
