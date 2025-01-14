require 'sinatra/base'

class GeminiApp < Sinatra::Base

  configure do
    set :environment, :production
    set :public_folder, 'public'

    set :bind, "127.0.0.1"
    set :port, 4001
    set :server, "puma"

    enable :logging
  end

  before do
    response.headers['x-clacks-overhead'] = "GNU Terry Pratchett"
  end
  
  get '/' do
    File.read 'public/index.html'
  end
  
  Dir['public/*'].select {|d| File.directory? d }.each do |path|
    dir = path[7..-1] # strip off the initial "public/"
    get "/#{dir}/?" do
      haml :manifest, :locals => {:dir => path}
    end
  end
end

