require 'weibo'
require './lib/credential_manager'

class WeiboSyncher
  ::Weibo::Config.api_key = "565166882"
  ::Weibo::Config.api_secret = "155610a46c6bce1ca7aa45ddc7fd1465"

  def initialize
    if credential = CredentialManager.load('weibo')
      @oauth = ::Weibo::OAuth.new(::Weibo::Config.api_key, ::Weibo::Config.api_secret)
      @oauth.authorize_from_access(credential["token"], credential["secret"])
    end
  end

  def update_status text
    ::Weibo::Base.new(@oauth).update(text)
  end
end

