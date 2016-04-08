class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
         
  belongs_to :client
	
  validates_presence_of :username, :password, :password_confirmation, on: :save
  validates_uniqueness_of :username, scope: :client
  validates_confirmation_of :password, on: :save
	
  scope :verification, ->(username, password){where(username: username, password: password).limit(1)}
  scope :actives, ->(client){where(client: client).order("updated_at DESC").limit(1)}
  scope :find_by_id, ->(id){ find_by id: id }
  
  def self.find_for_database_authentication(warden_conditions)
    conditions = warden_conditions.dup
    if login = conditions.delete(:login)
      where(conditions.to_hash).where(["lower(username) = :value OR lower(email) = :value", { :value => login.downcase }]).first
    else
      where(conditions.to_hash).first
    end
  end
		
  #METODOS PROPIOS DE LA CLASE
  def verification
	@users = User.verification(self.username, self.password)
	@users.length > 0
  end
	
  def firstUser
	@users[0]
  end
	
  def fullName
	self.client.fullName
  end
end
