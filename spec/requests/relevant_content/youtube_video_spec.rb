require "rails_helper"

RSpec.describe "Relevant Content", :vcr do
  describe "YouTube Video Request" do
    it "can get a list of 50 youtube videos" do
      keywords = "westworld robots sdagsjkhgskjdkjsdgsdg"

      get "/relevant_content?keywords=#{keywords}&tags=webdev java career&count=50"
      expect(response).to be_successful
      parsed_response = JSON.parse(response.body, symbolize_names: true)
      expect(parsed_response[:data][:attributes][:videos].length).to eq 50
    end
  end
end
