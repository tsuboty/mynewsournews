class AddColumnAccount < ActiveRecord::Migration
  def change
  	change_table :accounts do |t|

  		t.string 	:provider
  		t.integer 	:uid
  		t.string 	:nickname
  		t.string	:image
  		t.string	:oauth_token
  		t.datetime	:oauth_expires_at
  	
  	end
  end
end
