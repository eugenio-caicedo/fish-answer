class CreateVote < ActiveRecord::Migration
  def change
    create_table :votes do |t|
      t.float :rating
      t.belongs_to :client, index: true, foreign_key: true
      t.belongs_to :question, index: true, foreign_key: true
      
      t.timestamps
    end
  end
end
