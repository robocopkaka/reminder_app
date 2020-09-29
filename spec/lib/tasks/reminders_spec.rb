# frozen_string_literal: true

require "rails_helper"
require "rake"
require "sidekiq/testing"
Sidekiq::Testing.fake!
Rake.application.rake_require 'tasks/reminders'

RSpec.describe "reminders rake task" do
  let(:user) { create(:user) }
  let!(:reminders) { create_list(:reminder, 5, user: user) }
  before do
    Rake::Task.define_task(:environment)
  end
  
  context "when called" do
    it "does not raise an exception" do
      expect do
        Rake::Task["reminders:queue"].invoke
      end.to_not raise_exception
    end
  end
end
