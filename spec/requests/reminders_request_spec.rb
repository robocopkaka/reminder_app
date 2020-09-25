require 'rails_helper'

RSpec.describe "Reminders", type: :request do

  describe "GET /new" do
    it "returns http success" do
      get "/reminders/new"
      expect(response).to have_http_status(:success)
    end
  end

end
