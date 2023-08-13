require 'sinatra'


class GeminiApp < Sinatra::Base

  set :environment, :production
  set :public_folder, 'public'
  set :server, 'thin'

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

