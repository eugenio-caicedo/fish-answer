class CreateClients < ActiveRecord::Migration
  def change
    create_table :clients do |t|
      t.string :firstName
      t.string :lastFirstName
      t.boolean :sex
      t.integer :age

      t.timestamps
    end
  end
end
