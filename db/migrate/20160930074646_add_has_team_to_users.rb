class AddHasTeamToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :has_team, :boolean, default: false
  end
end
