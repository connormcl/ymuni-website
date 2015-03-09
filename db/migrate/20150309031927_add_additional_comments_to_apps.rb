class AddAdditionalCommentsToApps < ActiveRecord::Migration
  def change
  	add_column :apps, :additional_comments, :text
  end
end
