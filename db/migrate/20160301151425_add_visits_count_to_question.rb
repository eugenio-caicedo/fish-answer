class AddVisitsCountToQuestion < ActiveRecord::Migration
  def change
    add_column :questions, :visits_count, :integer, :default => 0
  end
end
