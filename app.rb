require 'rubygems'
require 'sinatra'
require 'sinatra/reloader'
require 'sinatra/activerecord'

set :database, "sqlite3:main.db"

class Client < ActiveRecord::Base
	validates :name, {presence: true}
	validates :phones, {presence: true}
	validates :datestamp, {presence: true}
	validates :color, {presence: true}
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

	c = Client.new params[:client]
	c.save

	erb "<div class='alert alert-success'>Thanks #{c.name}! #{nil} is waiting you at #{c.datestamp}.</div>"
end

get '/contacts' do
	erb :contacts
end

post '/contacts' do
	@email = params[:email]
	@message = params[:message]

	Contact.create :email => @email, :message => @message

	erb "<div class='alert alert-success'>Thanks! We will answer you to #{@email} soon.</div>"
end
