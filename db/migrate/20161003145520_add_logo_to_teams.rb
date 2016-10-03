class AddLogoToTeams < ActiveRecord::Migration[5.0]
  def change
    add_reference :teams, :logo, foreign_key: true
  end
end
