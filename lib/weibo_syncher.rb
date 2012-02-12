require 'weibo'
require './lib/credential_manager'
require './lib/since_id_manager'

class WeiboSyncher
  # TODO load from config, but weibo gem has a bug, so fix it or skip it.
  Weibo::Config.api_key = "565166882"
  Weibo::Config.api_secret = "155610a46c6bce1ca7aa45ddc7fd1465"

  attr_accessor :client

  def initialize
    credential = CredentialManager.load!('weibo')
    oauth = Weibo::OAuth.new(Weibo::Config.api_key, Weibo::Config.api_secret)
    oauth.authorize_from_access(credential["token"], credential["secret"])
    @client = Weibo::Base.new(oauth)
  end

  def update_status text
    @client.update(text)
  end

  def get_user_timeline
    since_id = SinceIdManager.load!("weibo", @client)
    @client.user_timeline(:since_id => since_id)
  end
end
