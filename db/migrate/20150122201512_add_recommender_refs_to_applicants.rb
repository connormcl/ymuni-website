class AddRecommenderRefsToApplicants < ActiveRecord::Migration
  def change
  	add_reference :users, :recommender, index: true
  end
end
