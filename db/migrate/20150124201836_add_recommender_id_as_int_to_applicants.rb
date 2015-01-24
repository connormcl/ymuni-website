class AddRecommenderIdAsIntToApplicants < ActiveRecord::Migration
  def change
  	remove_reference :applicants, :recommender, index: true

  	add_column :applicants, :recommender_id, :integer
  end
end
