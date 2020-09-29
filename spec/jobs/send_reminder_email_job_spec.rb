# frozen_string_literal: true

require 'rails_helper'
require "sidekiq/testing"

RSpec.describe SendReminderEmailJob, type: :job do
  let(:user) { create(:user) }
  let(:reminder) { create(:reminder, user: user) }
  
  context "when the job is called" do
    before do
      Sidekiq::Testing.inline!
      ActionMailer::Base.deliveries.clear
    end
    it "sends a mail to the user" do
      expect do
        SendReminderEmailJob.perform_now(reminder.id)
      end.to change(ActionMailer::Base.deliveries, :size).by 1
    end
    
    it "updates the scheduled status of the reminder" do
      reminder.update(scheduled: true)
      SendReminderEmailJob.perform_now(reminder.id)
      expect(reminder.reload.scheduled).to be false
    end
    
    it "schedules the next reminder a month ahead" do
      old_scheduled_at = reminder.next_scheduled_at
      Timecop.travel(old_scheduled_at) do
        SendReminderEmailJob.perform_now(reminder.id)
        expect(reminder.reload.next_scheduled_at)
          .to be > old_scheduled_at
      end
    end
    
    it "updates the last_run_at value" do
      SendReminderEmailJob.perform_now(reminder.id)
      last_run_at = reminder.reload.last_run_at
      expect(last_run_at).to_not be nil
      expect(last_run_at).to be < Time.current
    end
  end
end
