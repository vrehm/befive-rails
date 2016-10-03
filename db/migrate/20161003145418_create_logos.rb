class CreateLogos < ActiveRecord::Migration[5.0]
  def change
    create_table :logos do |t|
      t.string :color
      t.string :image

      t.timestamps
    end
  end
end
