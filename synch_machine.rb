%w(rubygems bundler).each { |dependency| require dependency }
Bundler.setup
%w(eventmachine oauth json weibo).each { |dependency| require dependency }

require File.join(".", "lib", "weibo_syncher")
require File.join(".", "lib", "twitter_syncher")

EM.run do
  weibo = WeiboSyncher.new
  twitter = TwitterSyncher.new

  EM.add_periodic_timer(60*1000) {
    weibo.get_user_timeline.each do |update|
      twitter.update_status update.text
    end
  }
end