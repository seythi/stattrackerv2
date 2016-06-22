class Pc < ActiveRecord::Base
  belongs_to :user
  belongs_to :campaign
  has_many :stats
  def editpermission? editor
  	uid = editor.id
  	return (uid == self.user.id or uid == self.campaign.user.id)
  end
end
