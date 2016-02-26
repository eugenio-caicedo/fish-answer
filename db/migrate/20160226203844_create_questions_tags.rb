class CreateQuestionsTags < ActiveRecord::Migration
  def change
    create_table :questions_tags, id: false do |t|
    	t.belongs_to :question, index: true, foreign_key: true
      	t.belongs_to :tag, index: true, foreign_key: true
    end
  end
end
