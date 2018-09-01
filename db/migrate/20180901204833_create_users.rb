class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.string :name
      t.string :username
      t.string :password_digest
      t.integer :points, default: 0
      t.integer :redeemed_points, default: 0
      t.integer :role, default: 0

      t.timestamps
    end
  end
end
