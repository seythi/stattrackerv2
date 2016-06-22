class Campaign < ActiveRecord::Base
  belongs_to :user
  has_many :pcs

  def ownedby? claimant
  	return claimant.id == user_id
  end
end
