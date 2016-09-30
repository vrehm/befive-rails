class RemoveManagerIdFromTeams < ActiveRecord::Migration[5.0]
  def change
    remove_column :teams, :manager_id, :bigint
  end
end
