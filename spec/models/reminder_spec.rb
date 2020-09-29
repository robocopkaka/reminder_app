require 'rails_helper'

RSpec.describe Reminder, type: :model do
  describe "validations" do
    it { should validate_presence_of(:day) }
    it { should validate_presence_of(:time) }
    it { should validate_presence_of(:title) }
  end
end
