class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
         
  belongs_to :client
	
  validates_presence_of :username, :email, :password, :password_confirmation, on: :save
  validates_uniqueness_of :username, :email, scope: :client
  validates_confirmation_of :password, on: :save
  
  scope :find_by_id, ->(id){ find_by id: id }
	
  def fullName
	self.client.fullName
  end
end
