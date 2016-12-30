class AuthenticateClients
  # def tweet_capture(token, secret)
  #   client = Twitter::REST::Client.new do |config|
  #     config.consumer_key        = ENV['TWITTER_CONSUMER_KEY']
  #     config.consumer_secret     = ENV['TWITTER_CONSUMER_SECRET']
  #     config.access_token        = token
  #     config.access_token_secret = secret
  #   end
  #
  #   client
  # end

  def self.tweetstream(token, secret)
    TweetStream.configure do |config|
      config.consumer_key       = ENV['TWITTER_CONSUMER_KEY']
      config.consumer_secret    = ENV['TWITTER_CONSUMER_SECRET']
      config.oauth_token        = token
      config.oauth_token_secret = secret
    end
  end
end
