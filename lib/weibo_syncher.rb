require 'weibo'
require 'credential_manager'
require 'since_id_manager'
require 'oauth_account_manager'

class WeiboSyncher
  # weibo gem has a bug, so fix it or skip it.
  Weibo::Config.api_key = OauthAccountManager.load!("weibo")["key"]
  Weibo::Config.api_secret = OauthAccountManager.load!("weibo")["secret"]

  attr_accessor :client

  def initialize
    credential = CredentialManager.load!('weibo')
    oauth = Weibo::OAuth.new(Weibo::Config.api_key, Weibo::Config.api_secret)
    oauth.authorize_from_access(credential["token"], credential["secret"])
    @client = Weibo::Base.new(oauth)
  end

  def update_status update
    @client.update(update.text)
  end

  def get_unsynched_updates
    since_id = SinceIdManager.load!("weibo", @client)
    @client.user_timeline(:since_id => since_id)
  end
end
