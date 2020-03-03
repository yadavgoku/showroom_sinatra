require 'sinatra'
require 'yaml/store'
require './core/showroom'


Need = {}


get '/' do
  @title = "Welcome to sinatra"
  erb :index
end
post '/action' do

  Need['need']  = params['action_required'].to_s
  erb :'action'

end
post '/perform_action' do
  Need['car'] = params['car_class']
  similar_actions = %w(change_air_bags order_air_bags order_tyres change_air_bags)
  if similar_actions.include? Need['need']
    Need['brand'] = params['brand']
  else
    Need['quantity'] = params['quantity']
  end

  @info = @showroom = Showroom.new.showroom(Need)
  @cars = @info['for_cars']
  erb :perform_action
end
