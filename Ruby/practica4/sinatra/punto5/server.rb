require 'bundler'
Bundler.require


get '/' do
  s = "Las rutas disponibles son: <br>"
  Sinatra::Application.routes['GET'].reduce(s) do |res, r|
    res << r.verb + " " + r.path + "<br>"
  end
end

get '/mcm/:a/:b' do |a, b|
  a.to_i.lcm(b.to_i).to_s
end

get '/mcd/:a/:b' do |a, b|
  a.to_i.gcd(b.to_i).to_s
end

get '/sum/*' do |nums|
  nums.split('/').map(&:to_i).sum.to_s
end

get '/even/*' do |nums|
  nums.split('/').map(&:to_i).select(&:even?).size.to_s
end

post '/random' do
  rand.to_s
end

post '/random/:lower/:upper' do |lower, upper|
  rand(lower.to_i..upper.to_i).to_s
end
