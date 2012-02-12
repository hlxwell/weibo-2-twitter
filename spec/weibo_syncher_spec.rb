require "./lib/weibo_syncher"

describe 'Weibo syncher' do
  it "should be able to load timeline" do
    weibo = WeiboSyncher.new
    updates = weibo.get_user_timeline
    updates.size.should > 0
  end
end