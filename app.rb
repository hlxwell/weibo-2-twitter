%w(rubygems bundler).each { |dependency| require dependency }
Bundler.setup
%w(pp compass sinatra slim sass coffee-script oauth json omniauth omniauth-twitter omniauth-weibo).each { |dependency| require dependency }

require File.join(".", "lib", "credential_manager")
require File.join(".", "lib", "weibo_syncher")
require File.join(".", "lib", "weibo_syncher")

################################################

use OmniAuth::Builder do
  provider :weibo, "565166882", "155610a46c6bce1ca7aa45ddc7fd1465"
  provider :twitter, "cQjOzUhp2zbvfklTezyxRg", "0jXzmtc8xoKwUphWE08Loe0ZPoNZZdLseOMXnmCkII"
end

enable :sessions

configure do
  set :public_folder, File.dirname(__FILE__) + '/public'
  set :views, File.dirname(__FILE__) + '/views'
  set :scss, {:style => :compact, :debug_info => false}
  Compass.add_project_configuration(File.join(Sinatra::Application.root, 'config', 'compass.rb'))
end

################################################

get "/" do
  slim :index
end

%w(get post).each do |method|
  send(method, "/auth/:provider/callback") do
    if CredentialManager.update env['omniauth.auth']
      redirect "/?message=done_bind_#{params[:provider]}"
    else
      redirect "/?message=failed_bind_#{params[:provider]}"
    end
  end
end

get "/auth/failure" do
  redirect "/?message=#{params[:message]}"
end

get '/application.css' do
  content_type 'text/css', :charset => 'utf-8'
  scss(:"stylesheets/application.css")
end
