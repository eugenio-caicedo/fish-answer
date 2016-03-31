class ChangeDataTypeForSexToClient < ActiveRecord::Migration
  def self.up
  	remove_column :clients, :sex
    add_column :clients, :sex, :integer, default: 0
  end
  def self.down
    remove_column :clients, :sex
    add_column :clients, :sex, :string
  end
end
