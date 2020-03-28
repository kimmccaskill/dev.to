require "rails_helper"

RSpec.describe "Creating an article with the editor", type: :system, vcr: true do
  let(:user) { create(:user) }
  let!(:template) { file_fixture("article_published.txt").read }
  let(:start_time) { VCR.current_cassette&.originally_recorded_at || Time.current }

  before do
    sign_in user
    $REDIS.flushall
    Timecop.travel(start_time)
  end

  it "creates a new article", js: true, retry: 3 do
    visit new_path
    fill_in "article_body_markdown", with: template
    click_button "SAVE CHANGES"
    expect(page).to have_selector("header h1", text: "Sample Article")
  end
end
