class HashtagSearchWorker
  include Sidekiq::Worker
  sidekiq_options retry: false

  def perform(hashtag, token, secret, entry)
    logger = Logger.new(STDOUT)
    logger.info "Starting a search for the hashtag: #{hashtag}"

    # statuses = []
    # client = TweetStream::Client.new
begin
    twitter 	= Twitter::REST::Client.new do |config|
        config.consumer_key        = ENV['TWITTER_CONSUMER_KEY']
        config.consumer_secret     = ENV['TWITTER_CONSUMER_SECRET']
        config.access_token        = token
        config.access_token_secret = secret
    end

    tweets = []

    options = {
      result_type: 'recent',
      count: 25,
      include_entities: true,
    }

    tweets = twitter.search("#{hashtag} filter:twimg -rt", options).take(25)

    tweets_with_pics = tweets.select{ |e| e.media.first.media_url.to_s if e.media?}

    saved_tweets = tweets_with_pics.map { |tweet|
      Tweet.create!(
        status: tweet.text.to_s,
        user_name: tweet.user.screen_name.to_s,
        media_url: tweet.media.first.media_url.to_s,
        tweet_sent_at: tweet.created_at,
        twitter_id: tweet.id.to_s,
        entry_id: entry
      )
       }

    logger.info "#{saved_tweets.count} tweets added to the Queue"

    # client.oauth_token = token
    # client.oauth_token_secret = secret
    # binding.pry

    # client.track(hashtag) do |status, client|
    #   if status.media? && status.retweeted_tweet? === false
    #     logger.info "Found a new tweet with the hashtag: #{hashtag}"
    #   # Add tweet to database after hashtag is found
    #     tweet = Tweet.create!(
    #       status: status.text.to_s,
    #       user_name: status.user.screen_name.to_s,
    #       media_url: status.media.first.media_url.to_s,
    #       tweet_sent_at: status.created_at,
    #       twitter_id: status.id.to_s,
    #       entry_id: entry
    #     )
    #     statuses << tweet
    #     logger.info "A new tweet is saved"
    #     client.stop if statuses.size >= 3
    #   end
    # end


    rescue Twitter::Error::TooManyRequests => error
        sleep error.rate_limit.reset_in + 1
        retry
      rescue => error
        puts error.inspect

    end

  end


end
