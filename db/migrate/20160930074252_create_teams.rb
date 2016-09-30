class CreateTeams < ActiveRecord::Migration[5.0]
  def change
    create_table :teams do |t|
      t.string :name
      t.string :city
      t.integer :manager_id, :limit=> 8

      t.timestamps
    end
  end
end
