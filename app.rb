require './traguito'
require 'json'
require 'byebug'

class App < Traguito
  ROUTES = {
    '/test' => { handler: :test, method: 'POST' }
  }

  def test
    respond :json do
      if test_params.valid?
        render :json, {status: 'ok'}
      else
        render :json, {error: 'invalid params'}, status: '422'
      end
    end
  end

  private

  def test_params
    params.require(['name', 'email'])
  end
end
