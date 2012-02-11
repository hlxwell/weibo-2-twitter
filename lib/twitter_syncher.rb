require "twitter"
require './lib/credential_manager'

class TwitterSyncher
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

  def update_status text
    @client.update(text)
  end
end

