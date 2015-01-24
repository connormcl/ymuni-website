class CreateApplicants < ActiveRecord::Migration
  def change
    create_table :applicants do |t|

      t.timestamps
    end

    add_reference :applicants, :recommender, index: true
  	remove_reference :apps, :recommender, index: true
  end
end
