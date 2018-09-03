class AddDisabledToRewards < ActiveRecord::Migration[5.1]
  def change
    add_column :rewards, :disabled, :integer, :default => 0
  end
end
