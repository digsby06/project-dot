class PageController < ApplicationController
  # before_action :authenticate_user!
  # def callback
  #   response = Instagram.get_access_token(param[:code], redirect_uri: ENV['REDIRECT_URI'])
  #   session[:access_token] = response.access_token
  #   redirect_to root_path
  # end




  def dashboard
    return unless current_user && current_user.instagram_authenticated?
      @entry = Entry.new
      @entries = Entry.all
      @display = Display.new
      @displays = Display.all

      tag = @entries.map { |entry| entry.hashtag}
      account = @entries.map {|entry| entry.account_name}


      @tags = current_user.find_by_instagram_tag(tag[0])
      @accounts = current_user.find_by_instagram_account(account[0])

  end


end
