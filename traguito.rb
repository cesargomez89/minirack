require './lib/params_parser'

class Traguito
  FORMATS = {
    json: 'application/json'
  }

  ROUTES = {
    '/' => :index
  }

  attr_reader :env, :request, :params

  def call(env)
    @env     = env
    @request = Rack::Request.new(env)
    @params  = ParamsParser.new(@request.body.read)

    send self.class::ROUTES[env['REQUEST_PATH']]
  end

  def index
    ['200', {'Content-Type' => 'text/plain'}, ['Hello World!']]
  end

  def respond(format)
    return invalid_format unless FORMATS[format] == env['CONTENT_TYPE']
    yield
  end

  def render(format, content, status: '200')
    [status, {'Content-Type' => FORMATS[format]}, [content.to_json]]
  end

  private

  def invalid_format
    render :json, { error: "invalid format: #{env['HTTP_ACCEPT']}" }, status: '400'
  end
end
