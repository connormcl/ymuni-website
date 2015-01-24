class FixingRecommenderIdPartTwo < ActiveRecord::Migration
  def change
  	remove_reference :recommenders, :applicant, index: true

  	remove_column :recommenders, :recommender_id, :integer
  end
end
