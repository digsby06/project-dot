# Schema for Display Table 
# create_table "displays", force: :cascade do |t|
#   t.string   "name"
#   t.boolean  "active_content"
#   t.datetime "created_at",     null: false
#   t.datetime "updated_at",     null: false
#   t.string   "file"
#   t.integer  "user_id"
#   t.index ["user_id"], name: "index_displays_on_user_id", using: :btree
# end

class Display < ApplicationRecord
  belongs_to :user
  has_many :entries, dependent: :destroy

  validates :file, presence: true
  validates :name, presence: true

  default_scope { order('created_at DESC')}
  scope :active_content, ->{ where(:active_content => true).order("created_at DESC") }

  mount_uploader :file, FileUploader






end
