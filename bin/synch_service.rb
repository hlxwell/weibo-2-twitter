#!/usr/bin/env ruby

APP_ROOT = File.expand_path(File.join(File.dirname(__FILE__) + '/..'))
APP_ENV =  ENV["APP_ENV"] || "development"
$LOAD_PATH.unshift(APP_ROOT + '/lib') unless $LOAD_PATH.include?(APP_ROOT + '/lib')

%w(rubygems bundler).each { |dependency| require dependency }
Bundler.setup
require 'daemons'

def stop_and_exit
  puts "Exiting..."
  exit 0
end

Signal.trap('INT') { stop_and_exit }
Signal.trap('TERM'){ stop_and_exit }

options = {
  :app_name => 'Weibo2Twitter',
  :multiple => false,
  :log_output => true,
  :dir_mode => :normal,
  :dir => File.join(APP_ROOT)
}

Daemons.run(File.join(APP_ROOT, 'synch_machine.rb'), options)