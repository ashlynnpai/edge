class AddPublicProfileToUsers < ActiveRecord::Migration
  def change
    add_column :users, :public_profile, :boolean, default: true
  end
end
