class AddComentsColumnCommunity < ActiveRecord::Migration
  def change
  	change_table :comments do |t|
  		t.integer "community_id"


  	end
  end
end
