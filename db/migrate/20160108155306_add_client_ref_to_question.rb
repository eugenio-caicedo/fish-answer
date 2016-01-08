class AddClientRefToQuestion < ActiveRecord::Migration
  def change
    add_reference :questions, :client, index: true, foreign_key: true
  end
end
