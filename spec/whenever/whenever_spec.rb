# frozen_string_literal: true

require "rails_helper"

RSpec.describe "whenever spec" do
  let(:schedule) {
    Whenever::Test::Schedule.new({ vars: { environment: "development" }})
  }
  context "schedule for reminders" do
    it "makes sure the rake task exists" do
      expect(schedule.jobs[:rake].first[:task]).to eq "reminders:queue"
    end
  
    it "runs every day" do
      expect(schedule.jobs[:rake].first[:every]).to eq [1.day]
    end
  end
end
