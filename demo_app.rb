require 'sinatra/base'
require 'net/http'

class DemoApp < Sinatra::Base

  get '/password_strength.js' do
    file_contents 'lib/password_strength.js'
  end

  get '/' do
    file_contents 'test/index.html'
  end

  get '/google_password_strength.json' do
    google_password_strength
  end

  def google_password_strength
    password = params[:gpass]
    score = nil
    uri = URI URI.encode("https://accounts.google.com/RatePassword?Passwd=#{password}")
    Net::HTTP.start uri.host, uri.port, use_ssl: uri.scheme == 'https' do |http|
      http.use_ssl = true
      score = http.request(Net::HTTP::Get.new uri.request_uri).body
    end
    score
  end

  def file_contents(file)
    File.open(file, 'r') {|f| f.read}
  end
end
