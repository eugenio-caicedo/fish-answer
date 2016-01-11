class Answer < ActiveRecord::Base
	belongs_to :client
	belongs_to :question
	
	scope :paginable, ->(page, limit){ paginate(:page => page, :per_page => limit) }
	scope :by_question, ->(question){ includes(:client).where(question: question) }
end
