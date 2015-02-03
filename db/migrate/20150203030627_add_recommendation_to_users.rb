class AddRecommendationToUsers < ActiveRecord::Migration
  def change
  	add_column :users, :recommendation, :string
  end
end
