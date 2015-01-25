class AddResumeToApplicants < ActiveRecord::Migration
  def change
    add_column :applicants, :resume, :string
  end
end
