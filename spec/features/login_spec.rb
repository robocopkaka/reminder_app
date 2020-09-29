# frozen_string_literal: true

# feature spec for signup
require "rails_helper"

RSpec.describe "login", type: :feature do
  let!(:user) { create(:user) }
  
  context "when user signs up with valid params" do
    before do
      visit sign_in_path
      expect(page.has_selector?(".sign-in")).to be true
      fill_in "Email", with: "robocopkaka@gmail.com"
      fill_in "Password", with: "password"
      click_on "Sign in"
    end
    it "redirects them to their reminders page" do
      expect(page).to have_current_path(reminders_path)
      expect(page).to have_content("You don't have any reminders set")
    end
  end
end
