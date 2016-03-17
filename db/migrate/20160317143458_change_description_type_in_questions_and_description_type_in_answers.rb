class ChangeDescriptionTypeInQuestionsAndDescriptionTypeInAnswers < ActiveRecord::Migration
  def self.up
    change_column :questions, :description, :text
    change_column :answers, :description, :text
  end
 
  def self.down
    change_column :questions, :description, :string
    change_column :answers, :description, :string
  end
end
