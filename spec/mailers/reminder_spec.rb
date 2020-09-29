# frozen_string_literal: true

require "rails_helper"

RSpec.describe ReminderMailer, type: :mailer do
  let(:user) { create(:user) }
  let!(:reminder) { create(:reminder, user: user) }
  
  describe "send reminder" do
    context "when the mailer is called" do
      it "sends out a mail to the user" do
        expect do
          ReminderMailer.with(
            email: reminder.user.email,
            title: reminder.title,
            description: reminder.description,
            day: reminder.day,
            time: reminder.time,
            ).send_reminder.deliver_later
        end.to change(ActionMailer::Base.deliveries, :size).by 1
      end
    end
    
    it "sends out the correct email details" do
      email = ReminderMailer.with(
        email: reminder.user.email,
        title: reminder.title,
        description: reminder.description,
        day: reminder.day,
        time: reminder.time,
        ).send_reminder.deliver_now
      
      expect(email.to).to eq [reminder.user.email]
      expect(email.subject).to eq "Reminder: #{reminder.title}"
      expect(email.body.to_s).to include reminder.description
      expect(email.body.to_s).to include reminder.day
      expect(email.body.to_s).to include reminder.time.strftime("%T")
    end
  end
end
