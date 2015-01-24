class FixingRecommenderIdPartOne < ActiveRecord::Migration
  def change
  	add_column :recommenders, :recommender_id, :integer
  	add_column :users, :recommender_id, :integer
  end
end
