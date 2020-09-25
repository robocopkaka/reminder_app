class CreateReminders < ActiveRecord::Migration[6.0]
  def change
    create_table :reminders do |t|
      t.string :title
      t.text :description
      t.time :time
      t.string :day

      t.timestamps
    end
  end
end
