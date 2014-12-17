class ChangeAccountUid < ActiveRecord::Migration
  def change
  	
  	change_table :accounts do |t|
  		t.remove :uid
  		t.string :uid
   		
  	end 

  end
end
