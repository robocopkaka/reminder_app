class CreateReminders < ActiveRecord::Migration[6.0]
  def change
    create_table :reminders do |t|
      t.string :title, null: false
      t.text :description
      t.time :time, null: false
      t.string :day, null: false
      t.json :validation_rules
      t.datetime :next_scheduled_at
      t.references :user

      t.timestamps
    end
  end
end
