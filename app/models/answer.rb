class Answer < ActiveRecord::Base
	belongs_to :client
	belongs_to :question
	
	scope :paginable, ->(page, limit){ paginate(:page => page, :per_page => limit) }
	scope :by_question, ->(question){ includes(:client).where(question: question) }
	
	#METODOS PROPIOS DE LA CLASE
	def createdAtFormated
		dateFormat created_at
	end
	
	def updatedAtFormated
		dateFormat updated_at
	end
	
private
	def dateFormat(date)
		date.strftime "%d-%m-%Y a las %H:%M"
	end
end
