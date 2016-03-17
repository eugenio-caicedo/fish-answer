class Question < ActiveRecord::Base
	ratyrate_rateable "vote"
	
	belongs_to :client
	has_many :answers, :dependent => :destroy
	has_many :votes, :dependent => :destroy
	has_and_belongs_to_many :tags, class_name: "Tag"
	
	accepts_nested_attributes_for :answers
	
	attr_accessor :tag_list
	
	after_find :set_tag_list 
	after_initialize :set_tag_list
			
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
	
	def save_or_update(params)
		registration = new_registration(params)
		registration.save_or_update
	end
	
	def update_visits_count
		registration = new_registration({visits_count: self.visits_count+=1 })
		registration.save_or_update
	end
	
	def validate_tag(tag_param)
		self.tags.any?{|tag| tag.description.downcase == tag_param.downcase }
	end
	
	def tag_list_split(&proc)
		self.tag_list.split(",").each { |tag| proc.call(tag) } #if !self.tag_list.nil?
	end
		
private
	def dateFormat(date)
		date.strftime "%d-%m-%Y a las %H:%M"
	end
	
	def new_registration(params)
		QuestionRegistration.new(self, params)
	end
	
	def set_tag_list
		if self.tag_list.nil?
			self.tag_list = ""
			self.tags.each { |tag| self.tag_list += "#{tag.description}, " }
		end
	end
	
end
