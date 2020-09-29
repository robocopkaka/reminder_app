# frozen_string_literal: true
namespace :reminders do
  desc "queue user reminders"
  
  task queue: :environment do
    reminders = Reminder.where(scheduled: false)
    reminders.each do |reminder|
      SendReminderEmailJob
        .set(wait_until: reminder.next_scheduled_at)
        .perform_later(reminder.id)
      reminder.update(scheduled: true)
    end
  end
end