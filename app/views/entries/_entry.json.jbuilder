json.extract! entry, :id, :entry_name, :display_id, :hashtag, :account_name, :fill_percentage, :account_active, :hashtag_active, :created_at, :updated_at
json.url entry_url(entry, format: :json)