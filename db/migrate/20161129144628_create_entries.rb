class CreateEntries < ActiveRecord::Migration[5.0]
  def change
    create_table :entries do |t|
      t.string :entry_name
      t.string :hashtag
      t.string :account_name
      t.integer :fill_percentage
      t.boolean :account_active
      t.boolean :hashtag_active
      t.references :display, index: true, foreign_key: true

      t.timestamps
    end
  end
end
