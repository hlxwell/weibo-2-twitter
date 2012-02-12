require "twitter"
require 'credential_manager'

# Just need to push state to twitter which content get from weibo
#
class TwitterSyncher
  # TODO load from config
  Twitter.configure do |config|
    config.consumer_key = "cQjOzUhp2zbvfklTezyxRg"
    config.consumer_secret = "0jXzmtc8xoKwUphWE08Loe0ZPoNZZdLseOMXnmCkII"
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
    @client.update update.text.slice(0..139)
    # update since id
    SinceIdManager.update("weibo", update.id)
  end
end

