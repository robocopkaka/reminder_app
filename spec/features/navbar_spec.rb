# frozen_string_literal: true

require "rails_helper"

RSpec.describe "navbar", type: :feature do
  let(:user) { create(:user) }
  
  context "when the user deletes a reminder" do
    # using last since reminders are ordered in descending order
    
    context "when the user is signed in" do
      before do
        sign_in(user)
        visit root_path
      end
      it "should have a logout link" do
        expect(page).to have_content("Logout")
      end
      
      it "should have links for reminders" do
        expect(page).to have_content("Add Reminder")
        expect(page).to have_content("View Reminders")
      end
    end
    
    context "when the user is not signed in" do
      before { visit root_path }
      it "should have login and sign up links" do
        expect(page).to have_content("Login")
        expect(page).to have_content("Signup")
      end
      
      it "should not have links for adding or viewing reminders" do
        expect(page).to_not have_content("Add Reminder")
        expect(page).to_not have_content("View Reminders")
      end
    end
  end
end
