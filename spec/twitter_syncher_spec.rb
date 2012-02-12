require "./lib/twitter_syncher"

describe 'Twitter syncher' do
  it "should be able to load timeline" do
    twitter = TwitterSyncher.new
    twitter.update_status "test"
    # can't test at home network
  end
end