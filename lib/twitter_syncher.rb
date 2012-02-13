require "twitter"
require 'credential_manager'

# Just need to push state to twitter which content get from weibo
#
class TwitterSyncher
  Twitter.configure do |config|
    config.consumer_key = OauthAccountManager.load!("twitter")["key"]
    config.consumer_secret = OauthAccountManager.load!("twitter")["secret"]
  end

  def initialize
    credential = CredentialManager.load!('twitter')
    @client = Twitter::Client.new(
      :oauth_token => credential["token"],
      :oauth_token_secret => credential["secret"]
    )
  end

  def update_status update
    # weibo support 280 english chars, but twitter only support 140
    @client.update update.text.slice(0..138)
    SinceIdManager.update("weibo", update.id) # update since id
  end
end

