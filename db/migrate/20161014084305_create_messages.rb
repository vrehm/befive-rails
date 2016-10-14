class CreateMessages < ActiveRecord::Migration[5.0]
  def change
    create_table :messages do |t|
      t.references :user, foreign_key: true
      t.string :recipient_email
      t.text :content

      t.timestamps
    end
  end
end
