class AddUserIdToBadgeinputs < ActiveRecord::Migration
  def change
    add_column :badgeinputs, :user_id, :integer
  end
end
