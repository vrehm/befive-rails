class CreateEvents < ActiveRecord::Migration[5.0]
  def change
    create_table :events do |t|
      t.references :user, foreign_key: true
      t.references :team, foreign_key: true
      t.references :location, foreign_key: true
      t.string :category
      t.datetime :datetime
      t.string :address

      t.timestamps
    end
  end
end
