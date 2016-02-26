class CreateFollower < ActiveRecord::Migration
  def change
    create_table :followers, id: false do |t|
      t.integer :client_id, index: true, foreign_key: true
      t.integer :client_follower_id, index: true, foreign_key: true
      
      t.timestamps
    end
  end
end
