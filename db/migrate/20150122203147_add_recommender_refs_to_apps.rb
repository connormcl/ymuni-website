class AddRecommenderRefsToApps < ActiveRecord::Migration
  def change
  	add_reference :apps, :recommender, index: true
  	remove_reference :users, :recommender, index: true
  end
end
