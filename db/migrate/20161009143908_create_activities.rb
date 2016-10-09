class CreateActivities < ActiveRecord::Migration[5.0]
  def change
    create_table :activities do |t|
      t.references :user, foreign_key: true
      t.references :team, foreign_key: true
      t.references :event, foreign_key: true
      t.references :member, foreign_key: true
      t.string :category

      t.timestamps
    end
  end
end
