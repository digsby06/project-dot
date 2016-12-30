class Tweet < ApplicationRecord
  belongs_to :entry
  validates :twitter_id, :uniqueness => true
end
