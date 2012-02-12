%w(rubygems bundler).each { |dependency| require dependency }
Bundler.setup
%w(eventmachine oauth json weibo weibo_syncher twitter_syncher).each { |dependency| require dependency }

EM.run do
  weibo = WeiboSyncher.new
  twitter = TwitterSyncher.new

  EM.add_periodic_timer(10) {
    puts "=== Checking weibo ==="
    weibo.get_unsynched_updates.each do |update|
      puts "found new updates, start to sync... #{update.text}"
      twitter.update_status update
    end
  }
end