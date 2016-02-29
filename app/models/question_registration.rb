class QuestionRegistration

	def initialize(question)
		@question = question
	end
	
	def save_or_update
		@question.class.transaction do
			@question.save
			validate_tag_list
		end
	end

private
	def validate_tag_list
		if !@question.tag_list.nil?
			@question.tag_list.split(",").each do |tag|
				if !@question.validate_tag(tag.strip)
					@question.tags.push Tag.find_or_create_by(description: tag.strip)
				end
			end
		end
	end
end