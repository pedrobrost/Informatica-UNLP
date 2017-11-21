class NumberToX
  def initialize(app)
    @app = app
  end

  def call(env)
    status, headers, response  = @app.call(env)
    new_response = response.map { |c| c.gsub(/\d/,'x') }
    [status, headers, new_response]
  end
end
