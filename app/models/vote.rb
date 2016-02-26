class Vote < ActiveRecord::Base
	belongs_to :client
	belongs_to :question
end