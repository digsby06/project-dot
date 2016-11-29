class AddFileToDisplays < ActiveRecord::Migration[5.0]
  def change
    add_column :displays, :file, :string
  end
end
