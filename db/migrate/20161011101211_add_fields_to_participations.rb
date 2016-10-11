class AddFieldsToParticipations < ActiveRecord::Migration[5.0]
  def change
    add_column :participations, :sent, :boolean, default: false
    add_column :participations, :pending, :boolean, default: false
    add_column :participations, :validated, :boolean, default: false
    add_column :participations, :refused, :boolean, default: false
  end
end
