require 'test_helper'

class QuestionTest < ActiveSupport::TestCase
  test "valid count tags of question" do
  	question = Question.find(1)
  	assert_equal 1, question.tags.count
  end
  
  test "valid delete tags of question" do
  	question = Question.find(1)
  	question.tags.delete(1)
  	assert_equal question.tags.count, 0
  	assert_equal 2, Tag.count
  end
  
  test "valid tags include in question" do
  	question = Question.find(1)
  	question.tag_list = "Historia, Programación, Comic"
  	question.save_or_update
  	assert_equal 3, question.tags.count
  	assert_equal 3, Tag.count
  end 
end
