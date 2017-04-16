require 'rubygems'
require 'sinatra'
require 'sinatra/reloader'
require 'sinatra/activerecord'


set :database, "sqlite3:main.db"

class Client < ActiveRecord::Base
end

class Master < ActiveRecord::Base
end

class Contact < ActiveRecord::Base
end

before do
	@masters=Master.order "created_at DESC"
end

get '/' do
	erb :index
end

get '/visit' do
		erb :visit
end

post '/visit' do
	@username = params[:username]
	@phone = params[:phone]
	@time = params[:time]
	@master = params[:master]
	@color = params[:color]

	Client.create :name => @username, :phones => @phone, :datestamp => @time, :barber => @master, :color => @color

	erb "<div class='alert alert-success'>Thanks #{@username}! #{@master} is waiting you at #{@time}.</div>"
end
