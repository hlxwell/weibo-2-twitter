%w(rubygems bundler).each { |dependency| require dependency }
Bundler.setup
%w(eventmachine oauth json weibo).each { |dependency| require dependency }

require File.join(".", "lib", "weibo_syncher")
require File.join(".", "lib", "twitter_syncher")

EM.run do
  weibo = WeiboSyncher.new
  weibo.update_status "test"

  twitter = TwitterSyncher.new
  twitter.update_status "test"
end