class AddPasswordDigestToApplicants < ActiveRecord::Migration
  def change
    add_column :applicants, :password_digest, :string
  end
end
