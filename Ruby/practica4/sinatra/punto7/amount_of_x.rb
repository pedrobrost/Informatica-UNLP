class AmountOfX
  def initialize(app)
    @app = app
  end

  def call(env)
    status, headers, response  = @app.call(env)
    headers['X-Xs-Count'] = response.to_s.count('x').to_s
    [status, headers, response]
  end
end
