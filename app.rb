require "sinatra"
require "sinatra/reloader" if development?
require "pry-byebug"
require "better_errors"
require_relative 'repositories/cookbook'
require_relative 'models/recipe'
set :bind, '0.0.0.0'
configure :development do
  use BetterErrors::Middleware
  BetterErrors.application_root = File.expand_path('..', __FILE__)
end

csv_file  = "/Users/timotheegoguely/code/timotheegoguely/fullstack-challenges/02-OOP/04-Cookbook-Day-Two/01-Cookbook-Advanced/lib/recipes.csv"
cookbook = Cookbook.new(csv_file)

get '/' do
  @recipes = cookbook.all
  erb :index
end

get '/new_recipe' do
  erb :new_recipe
end

post '/create' do
  @name = params[:recipe][:name]
  @cooking_time = params[:recipe][:cooking_time]
  @difficulty = params[:recipe][:difficulty]
  @description = params[:recipe][:description]
  recipe = Recipe.new(@name, @description, @cooking_time, @difficulty)
  cookbook.add_recipe(recipe)
  redirect to("/")
end

get '/about' do
  erb :about
end

get '/team/:username' do
  puts params[:username]
  "The username is #{params[:username]}"
end
