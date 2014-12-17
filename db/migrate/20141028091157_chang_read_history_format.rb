class ChangReadHistoryFormat < ActiveRecord::Migration
  def up
  	rename_column :read_histories, :member_id, :account_id

  end
end
