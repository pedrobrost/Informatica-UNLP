require 'bundler'
Bundler.require

require_relative 'partida.rb'

list = [Partida.new('hola'), Partida.new('chau'), Partida.new('test')]

post '/' do
  redirect "/partida/#{rand(list.size)}"
end

get '/partida/:id' do |id|
  list[id.to_i].summary
end

put '/partida/:id' do |id|
  list[id.to_i].try(params['intento'])
  redirect "/partida/#{id}"
end
