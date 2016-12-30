class CreateTweets < ActiveRecord::Migration[5.0]
  def change
    create_table :tweets do |t|
      t.text :status
      t.string :user_name
      t.text :media_url
      t.datetime :tweet_sent_at

      t.timestamps
    end
  end
end
