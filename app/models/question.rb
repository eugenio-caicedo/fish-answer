class Question < ActiveRecord::Base
	belongs_to :client
	has_many :answers, :dependent => :destroy
	accepts_nested_attributes_for :answers
		
	scope :recents, ->(page, limit){includes(:client).order("updated_at DESC").paginate(:page => page, :per_page => limit)}
	scope :client_recents, ->(client, page, limit){by_client(client).recents(page, limit)}
	scope :by_client, ->(client){ includes(:client).where(client: client) }
	scope :find_by_id, ->(id){ find_by id: id }
	
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
