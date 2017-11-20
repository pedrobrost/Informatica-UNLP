require 'sinatra'

get '/' do
  num = rand(1..5)
  code = num == 5 ? 200 : 404
  [code, [num.to_s]]
end
