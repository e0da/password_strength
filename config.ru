$: << 'lib'

require 'password_strength'
require 'net/http'

BODY_404 = <<EOF
<!DOCTYPE html>
<title>Error 404 Not Found</title>
<h1>Error 404: Not Found</h1>
Nothing exists at this location.
EOF

ASSETS = [
  {
    route: %r[^/password_strength/password_strength.js$],
    type: 'application/javascript',
    body: proc { file_contents 'lib/password_strength.js' }
  }, 
  {
    route: %r[^/password_strength/(index.html)?$],
    type: 'text/html',
    body: proc { file_contents 'test/index.html' }
  },
  {
    route: %r[^/password_strength/google_password_strength.json\?gpass=],
    type: 'application/json',
    body: proc { google_password_strength }
  }
]

def parse_parms
  @parms = {}
  @env['QUERY_STRING'].split('&').map do |p|
    k_v = p.split '='
    @parms[k_v[0].to_sym] = k_v[1]
  end
end

def google_password_strength
  password = @parms[:gpass]
  score = nil
  uri = URI "https://accounts.google.com/RatePassword?Passwd=#{password}"
  Net::HTTP.start uri.host, uri.port, use_ssl: uri.scheme == 'https' do |http|
    http.use_ssl = true
    score = http.request(Net::HTTP::Get.new uri.request_uri).body
  end
  score
end

def file_contents(file)
  File.open(file, 'r') {|f| f.read}
end

app = proc do |env|

  @env = env
  parse_parms

  asset = ASSETS.find {|a| a[:route].match @env['REQUEST_URI'] }

  if asset

    type = asset[:type]
    body = asset[:body].call

    headers = {
      'Content-Type' => type,
      'Content-Length' => body.length.to_s
    }

    if type == 'application/json'
      headers['Cache-Control'] = 'no-cache, must-revalidate'
      headers['Expires'] = 'Mon, 26, Jul 1997 05:00:00 GMT'
    end

    [ 200, headers, body ]

  else
    [
      404,
      {
        'Content-Type' => 'text/html',
        'Content-Length' => BODY_404.length.to_s
      },
      BODY_404
    ]
  end
end

run app
