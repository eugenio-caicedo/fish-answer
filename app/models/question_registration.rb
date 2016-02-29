class QuestionRegistration

	def initialize(question, params_question)
		@question = question
		@params_question = params_question
		@question.tag_list = params_question[:tag_list] if params_question[:tag_list].present?
	end
	
	def save_or_update
		@question.class.transaction do
			@question.save(@params_question)
			validate_tag_list
		end
	end

private
	def validate_tag_list
		@question.tags.delete_all
		@question.tag_list_split do |tag|
			puts tag
			if !@question.validate_tag(tag.strip) and tag.delete(' ') != ""
				@question.tags.push Tag.find_or_create_by(description: tag.strip)
			end
		end
	end
end