class Display < ApplicationRecord
  has_many :entries, dependent: :destroy

  validates :file, presence: true
  validates :name, presence: true

  default_scope { order('created_at DESC')}
  scope :active_content, ->{ where(:active_content => true).order("created_at DESC") }

  mount_uploader :file, FileUploader






end
