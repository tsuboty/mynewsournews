class ModifyCommentColumn < ActiveRecord::Migration
  def change

  	change_table :comments do |t|
  		t.remove :member_id
  		t.string :account_id
   		
  	end

  end
end
