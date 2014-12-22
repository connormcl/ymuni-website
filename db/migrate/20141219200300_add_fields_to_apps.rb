class AddFieldsToApps < ActiveRecord::Migration
  def change
  	change_column :apps, :zip_code, :string

  	add_column :apps, :address, :string
  	add_column :apps, :date_of_birth, :date
  	add_column :apps, :ethnicity, :string
  	add_column :apps, :school_name, :string
  	add_column :apps, :school_address, :string
  	add_column :apps, :school_city, :string
  	add_column :apps, :school_state, :string
  	add_column :apps, :school_zip_code, :string
  	add_column :apps, :school_country, :string
  	add_column :apps, :grade_level, :string
  	add_column :apps, :email, :string
  	add_column :apps, :phone_number, :string
  end
end
