# frozen_string_literal: true

require "rails_helper"

RSpec.describe "delete reminders", type: :feature do
  let(:user) { create(:user) }
  
  context "when the user deletes a reminder" do
    let!(:reminders) { create_list(:reminder, 20, user: user) }
    # using last since reminders are ordered in descending order
    let(:last_reminder) { reminders.last }
    before do
      sign_in(user)
      
      within "#reminder-#{last_reminder.id}" do
        click_on "Delete Reminder"
      end
      visit reminders_path
    end
    
    it "should redirect to the reminders page" do
      expect(page).to have_current_path(reminders_path)
    end
    
    it "should not have the deleted reminder" do
      expect(page).to_not have_content(last_reminder.title)
    end
  end
end
