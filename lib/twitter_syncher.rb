require "twitter"
require './lib/credential_manager'

class TwitterSyncher
  def initialize
    if credential = CredentialManager.load('twitter')
      Twitter.configure do |config|
        config.consumer_key = "cQjOzUhp2zbvfklTezyxRg"
        config.consumer_secret = "0jXzmtc8xoKwUphWE08Loe0ZPoNZZdLseOMXnmCkII"
        config.oauth_token = credential["token"]
        config.oauth_token_secret = credential["secret"]
      end
    end
  end

  def update_status text
    Twitter.update(text)
  end
end

