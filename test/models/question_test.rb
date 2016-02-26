require 'test_helper'

class QuestionTest < ActiveSupport::TestCase
  test "valid count tags of question" do
  	question = Question.find(1)
  	assert_equal question.tags.count, 1
  end
  
  test "valid delete tags of question" do
  	question = Question.find(1)
  	question.tags.delete(1)
  	assert_equal question.tags.count, 0
  	assert_equal 2, Tag.count
  end
end
