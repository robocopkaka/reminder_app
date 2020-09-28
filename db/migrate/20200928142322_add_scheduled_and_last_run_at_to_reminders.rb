class AddScheduledAndLastRunAtToReminders < ActiveRecord::Migration[6.0]
  def up
    add_column :reminders, :scheduled, :boolean
    add_column :reminders, :last_run_at, :datetime
    change_column_default :reminders, :scheduled, false
  end
  
  def down
    remove_column :reminders, :scheduled
    remove_column :reminders, :last_run_at
  end
end
