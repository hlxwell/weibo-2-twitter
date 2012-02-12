require "./lib/twitter_syncher"

describe 'Twitter syncher' do
  it "should be able to load timeline" do
    weibo = WeiboSyncher.new
    update = weibo.client.user_timeline(:count => 1).last

    twitter = TwitterSyncher.new
    twitter.update_status update

    SinceIdManager.load!("weibo", weibo).should eq(update.id)
  end
end

def get_one_update
end