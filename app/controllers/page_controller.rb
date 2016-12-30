class PageController < ApplicationController
  before_action :user_signed_in!


  def test
    return unless current_user && current_user.twitter_authenticated?


    tweets = []
    options = {
      result_type: 'recent',
      count: 25,
      include_entities: true,
    }

    # tweets = twitter.search('#nba filter:twimg -rt', options).take(10)

    tweets =  twitter.search('#nba filter:twimg -rt', options).take(20)

    tweets_with_pics = tweets.select{ |e| e.media.first.media_url.to_s if e.media?}

    @saved_tweets = tweets_with_pics.map { |tweet|
      Tweet.create!(
        status: tweet.text.to_s,
        user_name: tweet.user.screen_name.to_s,
        media_url: tweet.media.first.media_url.to_s,
        tweet_sent_at: tweet.created_at,
        twitter_id: tweet.id.to_s
      )
       }

    # render partial: "page/loadtweets"
  end


  def previewmode
    return unless current_user && current_user.twitter_authenticated?
      @displays = Display.all
      @entries = Entry.all
  end


  def dashboard
    return unless current_user && current_user.twitter_authenticated?

      # current_user_token = current_user.twitter_authentication.token
      # current_user_secret = current_user.twitter_authentication.secret

      @entry = Entry.new
      @entries = Entry.all
      @display = Display.new
      @displays = Display.all

      # if @entries.present?
      # # To Do - if the display for entries is active, search hashtags associated with the created entries
      #   @hashtags = @entries.map(&:hashtag)
      #
      #   hashtag = @hashtags.first
      #   pound_and_tag = "#" + hashtag
      #
      # #Use SideKiq worker to perform tweet search for tweets that use hashtag
      #   HashtagSearchWorker.perform_async(pound_and_tag, current_user_token, current_user_secret)
      #
      # end

      # To Do - Perform a GET request by entry_id to /Tweets.json to retrieve media_url, status, and relevant info for twitter card element
      @tweets = Tweet.all
      @filtered_tweets = @tweets.map(&:media_url).uniq

  end

  private

  def current_user_token
    current_user.twitter_authentication.token

  end
  def current_user_secret
    current_user.twitter_authentication.secret
  end

  def twitter
    twitter 	= Twitter::REST::Client.new do |config|
				config.consumer_key        = ENV['TWITTER_CONSUMER_KEY']
				config.consumer_secret     = ENV['TWITTER_CONSUMER_SECRET']
				config.access_token        = current_user_token
				config.access_token_secret = current_user_secret
		end
  end



end
