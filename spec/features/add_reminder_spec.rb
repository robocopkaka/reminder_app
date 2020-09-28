# frozen_string_literal: true

require "rails_helper"

RSpec.describe "add_reminder", type: :feature do
  let!(:user) { create(:user) }
  before do
    visit sign_in_path
    fill_in "Email", with: "robocopkaka@gmail.com"
    fill_in "Password", with: "password"
    click_on "Sign in"
  end
  context "when valid parameters are supplied" do
    let!(:reminders_count) { Reminder.count }
    before do
      visit new_reminder_path
      fill_in "Title", with: "Test reminder"
      fill_in "Description", with: "Test description"
      select "Monthly on the 1st Sunday",
             from: "reminder[day]"
      fill_in "reminder[time]", with: "10:00"
      click_on "Create reminder"
    end
    it "redirects to the home page" do
      expect(page).to have_current_path(root_path)
      expect(page).to have_content("Welcome to my reminders app")
    end
    
    it "creates a reminder" do
      expect(Reminder.count).to eq reminders_count + 1
      expect(Reminder.last.title).to eq "Test reminder"
      expect(Reminder.last.day).to eq "Monthly on the 1st Sunday"
    end
  end
  
  context "when invalid params are passed" do
    before do
      visit new_reminder_path
      fill_in "Description", with: "Test"
      select "",
             from: "reminder[day]", match: :first
      click_on "Create reminder"
    end
    it "should show the errors" do
      expect(page).to have_content("Time can't be blank")
      expect(page).to have_content("Title can't be blank")
      expect(page).to have_content("Day can't be blank")
      expect(page.has_selector?("#error_explanation")).to be true
    end
  end
end
