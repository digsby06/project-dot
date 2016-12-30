class AddEntryToTweet < ActiveRecord::Migration[5.0]
  def change
    add_reference :tweets, :entry, foreign_key: true
  end
end
