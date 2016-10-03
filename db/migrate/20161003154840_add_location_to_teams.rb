class AddLocationToTeams < ActiveRecord::Migration[5.0]
  def change
    add_reference :teams, :location, foreign_key: true
  end
end
