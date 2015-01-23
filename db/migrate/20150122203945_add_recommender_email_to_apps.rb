class AddRecommenderEmailToApps < ActiveRecord::Migration
  def change
  	add_column :apps, :recommender_email, :string
  end
end
