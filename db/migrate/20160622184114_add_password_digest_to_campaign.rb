class AddPasswordDigestToCampaign < ActiveRecord::Migration
  def change
  	add_column :campaigns, :password_digest, :string
  end
end
