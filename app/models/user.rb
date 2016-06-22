class User < ActiveRecord::Base
	has_secure_password
	has_many :campaigns
	has_many :pcs
	has_many :victims, through: :campaigns, source: :pc
end
