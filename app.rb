require 'rubygems'
require 'sinatra'
require 'sinatra/reloader'
require 'sinatra/activerecord'


set :database, "sqlite3:main.db"

class Client < ActiveRecord::Base
end

class Master < ActiveRecord::Base
end

get '/' do
	erb "Hello!"
end
