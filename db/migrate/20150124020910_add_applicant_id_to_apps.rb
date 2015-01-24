class AddApplicantIdToApps < ActiveRecord::Migration
  def change
  	add_reference :apps, :applicant, index: true
  	remove_reference :apps, :user, index: true

  	add_reference :recommenders, :applicant, index: true
  	remove_reference :applicants, :recommender, index: true
  end
end
