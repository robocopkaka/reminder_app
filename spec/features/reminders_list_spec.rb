# frozen_string_literal: true

require "rails_helper"

RSpec.describe "reminders page", type: :feature do
  let(:user) { create(:user) }
  
  context "when the user has reminders" do
    let!(:reminders) { create_list(:reminder, 20, user: user) }
    before do
      sign_in(user)
    end
  
    it "should show a list of reminders" do
      # using last since reminders are ordered in descending order
      expect(page).to have_content(reminders.last.title)
    end
    
    it "should have pagination links" do
      expect(page.has_selector?("#pagination-links")).to be true
    end
    
    it "should have 10 reminders on the first page" do
      reminders_count = all(".reminder-card").count
      expect(reminders_count).to eq 10
    end
    
    it "should have delete buttons for card" do
      buttons_count = all("#delete-button").count
      expect(buttons_count).to eq 10
    end
    
    it "should have a header" do
      expect(page.has_selector?("h5")).to be true
      expect(page).to have_content "Your reminders"
    end
  end
  
  context "when the user has no reminder" do
    before do
      sign_in(user)
    end
    it "should show a message informing the user" do
      expect(page).to have_content "You don't have any reminders set"
    end
  end
end
