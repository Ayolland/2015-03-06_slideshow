require "sinatra"
require 'json'
require "sqlite3"
require 'pry'

DATABASE = SQLite3::Database.new("slides.db")
DATABASE.results_as_hash = true

require_relative 'models/slide.rb'

get "/" do
  @slide = Slide.all.sample
  erb :'slideshow'
end

get "/next/:current_stack" do
  Slide.find(params[:current_stack]).next.to_hash.to_json
end

get "/prev/:current_stack" do
  Slide.find(params[:current_stack]).prev.to_hash.to_json
end

get "/admin" do
  erb :'admin'
end