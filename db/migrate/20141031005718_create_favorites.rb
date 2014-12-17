class CreateFavorites < ActiveRecord::Migration
  def change
    create_table :favorites do |t|

      t.integer 	:account_id
      t.integer		:article_id
      t.boolean		:favorite_flag

      t.timestamps
    end
  end
end
