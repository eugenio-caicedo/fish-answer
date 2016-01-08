class Question < ActiveRecord::Base
	belongs_to :client
	
	scope :recents, ->(page, limit){includes(:client).order("updated_at DESC").paginate(:page => page, :per_page => limit)}
	scope :client_recents, ->(client, page, limit){by_client(client).recents(page, limit)}
	scope :by_client, ->(client){ includes(:client).where(client: client) }
	
	#METODOS PROPIOS DE LA CLASE
	def createdAtFormated
		dateFormat created_at
	end
	
private
	def dateFormat(date)
		date.strftime "%H:%M %d-%m-%Y"
	end
end
