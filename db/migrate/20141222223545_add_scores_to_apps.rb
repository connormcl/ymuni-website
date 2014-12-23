class AddScoresToApps < ActiveRecord::Migration
  def change
  	add_column :apps, :gpa, :float
  	add_column :apps, :sat_score, :integer
  	add_column :apps, :act_score, :integer
  	add_column :apps, :toefl_score, :integer
  end
end
