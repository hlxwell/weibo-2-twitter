%w(rubygems bundler).each { |dependency| require dependency }
Bundler.setup
%w(eventmachine oauth json weibo).each { |dependency| require dependency }

require File.join(".", "lib", "weibo_syncher")
require File.join(".", "lib", "twitter_syncher")

EM.run do
  weibo = WeiboSyncher.new
  twitter = TwitterSyncher.new

  EM.add_periodic_timer(10000) {
    puts "=== Checking weibo ==="
    weibo.get_user_timeline.each do |update|
      puts "found new updates, start to sync..."
      twitter.update_status update.text
    end
  }
end