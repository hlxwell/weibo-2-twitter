require "./lib/since_id_manager"
require "./lib/weibo_syncher"

describe 'Since ID manager' do
  it "should load provider config" do
    weibo = WeiboSyncher.new

    SinceIdManager.load!("weibo", weibo.client).should eq(nil)
    SinceIdManager.update "weibo", "123"
    SinceIdManager.load!("weibo", weibo.client).should eq("123")
    
    SinceIdManager.update "weibo", nil
  end
end