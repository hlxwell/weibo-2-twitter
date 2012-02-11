require 'weibo'
require './lib/credential_manager'
require './lib/latest_update_manager'

class WeiboSyncher
  Weibo::Config.api_key = "565166882"
  Weibo::Config.api_secret = "155610a46c6bce1ca7aa45ddc7fd1465"

  def initialize
    credential = CredentialManager.load!('weibo')
    oauth = Weibo::OAuth.new(Weibo::Config.api_key, Weibo::Config.api_secret)
    oauth.authorize_from_access(credential["token"], credential["secret"])
    @client = Weibo::Base.new(oauth)
  end

  def update_status text
    @client.update(text)
  end

  def user_timeline
    @client.user_timeline
  end

  def get_user_timeline
    if since_id = LatestUpdateManager.load("weibo")
      @client.user_timeline(:since_id => since_id)
    else
      since_id = @client.user_timeline(:count => 1).last.try(:id)
      LatestUpdateManager.set_last_update_id("weibo", since_id)
      []
    end
  end
end

