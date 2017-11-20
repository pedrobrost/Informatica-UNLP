require "rack"

class MoL
  def call(env)
    num = rand(1..42)
    code = num == 42 ? 200 : 404
    [ code, { "Content-Type" => "text/plain" }, [num.to_s] ]
  end
end

Rack::Handler::WEBrick.run MoL.new
