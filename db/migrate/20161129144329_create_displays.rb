class CreateDisplays < ActiveRecord::Migration[5.0]
  def change
    create_table :displays do |t|
      t.string :name
      t.boolean :active_content

      t.timestamps
    end
  end
end
