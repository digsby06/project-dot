class AlterColumnTweetsTwitterId < ActiveRecord::Migration[5.0]
  def self.up
    change_table :tweets do |t|
      t.change :twitter_id, :string
    end
  end
  def self.down
    change_table :tweets do |t|
      t.change :twitter_id, :integer
    end
  end
end
