class AddFieldsToEvents < ActiveRecord::Migration[5.0]
  def change
    add_column :events, :date, :date
    add_column :events, :time, :time
  end
end
