class AddFieldsToMembers < ActiveRecord::Migration[5.0]
  def change
    add_column :members, :pending, :boolean, default: false
    add_column :members, :validated, :boolean, default: false
  end
end
