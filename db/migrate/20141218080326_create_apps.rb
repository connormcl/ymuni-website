class CreateApps < ActiveRecord::Migration
  def change
    create_table :apps do |t|
    	t.string :first_name
    	t.string :middle_name
    	t.string :last_name
    	t.string :city
    	t.string :state
    	t.integer :zip_code
    	t.string :country

    	t.references :user, index: true

    	t.timestamps
    end
  end
end
