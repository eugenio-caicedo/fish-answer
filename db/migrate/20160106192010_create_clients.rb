class CreateClients < ActiveRecord::Migration
  def change
    create_table :clients do |t|
      t.string :first_name
      t.string :first_last_name
      t.string :sex
      t.integer :age

      t.timestamps
    end
  end
end
