class AddRecommenderIdToApplicants < ActiveRecord::Migration
  def change
  	add_reference :applicants, :recommender, index: true
  end
end
