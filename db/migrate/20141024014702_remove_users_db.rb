class RemoveUsersDb < ActiveRecord::Migration
  def change
  	 drop_table :fbusers
  	 drop_table :members
  	 drop_table :users
  	 
  end
end
