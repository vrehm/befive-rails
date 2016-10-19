class AddOpponentToEvents < ActiveRecord::Migration[5.0]
  def change
    add_column :events, :opponent, :string
  end
end
