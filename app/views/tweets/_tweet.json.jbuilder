json.extract! tweet, :id, :user_name, :status, :media_url, :tweet_sent_at, :twitter_id, :entry_id, :created_at, :updated_at
json.url tweet_url(tweet, format: :json)
