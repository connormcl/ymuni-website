class AddEssaysToApps < ActiveRecord::Migration
  def change
  	add_column :apps, :personal_statement, :text
  	add_column :apps, :supplemental_question_1, :text
  	add_column :apps, :supplemental_question_2, :text
  	add_column :apps, :supplemental_question_3, :text
  	add_column :apps, :supplemental_question_4, :text
  	add_column :apps, :supplemental_question_5, :text
  end
end
