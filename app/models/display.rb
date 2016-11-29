class Display < ApplicationRecord
  has_many :entries, dependent: :destroy
end
