require './lib/params_parser'

class Traguito
  FORMATS = {
    json: 'application/json'
  }

  ROUTES = {
    '/' => { handler: :index, method: 'GET' }
  }

  attr_reader :env, :request, :params

  def call(env)
    @env     = env
    @request = Rack::Request.new(env)
    @params  = ParamsParser.new(@request.body.read)

    return invalid_method unless route[:method] == env['REQUEST_METHOD']
    send route[:handler]
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

  def route
    @route ||= self.class::ROUTES[env['REQUEST_PATH']]
  end

  def invalid_format
    render :json, { error: "invalid format: #{env['HTTP_ACCEPT']}" }, status: '400'
  end

  def invalid_method
    render :json, { error: "invalid method: #{env['REQUEST_METHOD']}" }, status: '405'
  end
end
