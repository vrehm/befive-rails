class AddWaitingListToParticipations < ActiveRecord::Migration[5.0]
  def change
    add_column :participations, :waiting_list, :boolean, default: false
  end
end
