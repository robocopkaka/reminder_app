# frozen_string_literal: true

# feature spec for signup
require "rails_helper"

RSpec.describe "signup" do
  context "when user signs up with valid params" do
    before do
      visit sign_up_path
      expect(page.has_selector?(".sign-up")).to be true
      fill_in "Email", with: "robocopkaka@gmail.com"
      fill_in "Password", with: "password"
      click_on "Sign up"
    end
    it "redirects them to the home page" do
      expect(page).to have_current_path(reminders_path)
      expect(page).to have_content("You don't have any reminders set")
    end
    
    it "adds a new user" do
      expect(User.last.email).to eq "robocopkaka@gmail.com"
    end
  end
  
  context "when a user tries to signup with invalid params" do
    before do
      visit sign_up_path
      expect(page.has_selector?(".sign-up")).to be true
      fill_in "Email", with: ""
      fill_in "Password", with: ""
      click_on "Sign up"
    end
    
    it "returns error messages" do
      expect(page).to have_content "Email can't be blank"
      expect(page).to have_content "Password can't be blank"
    end
  end
end
