class SendReminderEmailJob < ApplicationJob
  self.queue_adapter = :sidekiq
  queue_as :default

  def perform(id)
    reminder = Reminder.find(id)
    ReminderMailer
      .with(
        email: reminder.user.email,
        title: reminder.title,
        description: reminder.description,
        day: reminder.day,
        time: reminder.time,
      )
      .send_reminder.deliver_now
    update_scheduled_at(reminder)
  end
  
  private
  
  def update_scheduled_at(reminder)
    ice_cube_rule = IceCube::Rule.from_hash(reminder.validation_rules)
    schedule = IceCube::Schedule.new(now = Time.current) do |s|
      s.add_recurrence_rule(ice_cube_rule)
      s.add_exception_time(now)
    end
    next_time = schedule.occurrences(Time.current + 2.months).first
    combined_time = "#{next_time.strftime("%F")} #{reminder.time.strftime("%T")}"
    reminder.update!(
      next_scheduled_at: Time.zone.parse(combined_time),
      last_run_at: Time.current,
      scheduled: false
    )
  end
end
