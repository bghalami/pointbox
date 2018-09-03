class CreateRewards < ActiveRecord::Migration[5.1]
  def change
    create_table :rewards do |t|
      t.string :title
      t.integer :price
      t.string :description
      t.timestamps
    end
  end
end
