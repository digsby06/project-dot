class Entry < ApplicationRecord
  belongs_to :display
  has_many :tweets, dependent: :destroy

end
