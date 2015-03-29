class CreateBadgeinputs < ActiveRecord::Migration
  def change
    create_table :badgeinputs do |t|
      t.string :treehouse_name
      t.string :codeschool_name
      t.string :codewars_name
      t.string :github_name
      t.timestamps
    end
  end
end
