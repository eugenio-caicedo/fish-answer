class Question < ActiveRecord::Base
	belongs_to :client
	has_many :answers, :dependent => :destroy
	has_many :votes, :dependent => :destroy
	has_and_belongs_to_many :tags, class_name: "Tag"
	
	accepts_nested_attributes_for :answers
	
	attr_accessor :tag_list
			
	scope :recents, ->(page, limit){includes(:client).order("updated_at DESC").paginate(:page => page, :per_page => limit)}
	scope :client_recents, ->(client, page, limit){by_client(client).recents(page, limit)}
	scope :by_client, ->(client){ includes(:client).where(client: client) }
	scope :find_by_id, ->(id){ find_by id: id }
	
	#METODOS PROPIOS DE LA CLASE
	def createdAtFormated
		dateFormat created_at
	end
	
	def save_or_update
		registration = QuestionRegistration.new(self)
		registration.save_or_update
	end
	
	def validate_tag(tag_param)
		self.tags.any?{|tag| tag.description.downcase == tag_param.downcase }
	end
	
private
	def dateFormat(date)
		date.strftime "%H:%M %d-%m-%Y"
	end
	
end
