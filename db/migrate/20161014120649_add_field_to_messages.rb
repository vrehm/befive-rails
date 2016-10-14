class AddFieldToMessages < ActiveRecord::Migration[5.0]
  def change
    add_column :messages, :recipient_first_name, :string
  end
end
