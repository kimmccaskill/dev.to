require "rails_helper"

RSpec.describe "Relevant Content" do
  describe "YouTube Video Request", :vcr do
    let(:start_time) { VCR.current_cassette&.originally_recorded_at || Time.current }

    before do
      $REDIS.flushall
      Timecop.travel(start_time)
    end

    it "can get a list of 50 youtube videos" do
      keywords = "westworld robots"

      get "/relevant_content?keywords=#{keywords}"
      expect(response).to be_successful
      parsed_response = JSON.parse(response.body, symbolize_names: true)
      expect(parsed_response[:data][:attributes][:videos].length).to eq 50
    end

    it "can get a list of videos from cache" do
      keywords = "westworld robots"

      get "/relevant_content?keywords=#{keywords}"
      expect(response).to be_successful
      parsed_response = JSON.parse(response.body, symbolize_names: true)
      expect(parsed_response[:data][:attributes][:videos].length).to eq 50

      get "/relevant_content?keywords=#{keywords}"
      expect(response).to be_successful
      parsed_response = JSON.parse(response.body, symbolize_names: true)
      expect(parsed_response[:data][:attributes][:videos].length).to eq 50
    end

    it "can get a specified count of videos" do
      keywords = "westworld robots"

      get "/relevant_content?keywords=#{keywords}&count=5"
      expect(response).to be_successful
      parsed_response = JSON.parse(response.body, symbolize_names: true)
      expect(parsed_response[:data][:attributes][:videos].length).to eq 5
    end

    it "can get a list of videos from tags if no keywords given" do
      tags = "git, java, beginners, career"

      get "/relevant_content?tags=#{tags}"
      expect(response).to be_successful
      parsed_response = JSON.parse(response.body, symbolize_names: true)
      expect(parsed_response[:data][:attributes][:videos].length).to eq 50
    end
  end
end
