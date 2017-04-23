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
	validates :email, {presence: true}
	validates :message, {presence: true}
end

before do
	@masters=Master.order "created_at DESC"
	@errors_list = {
									"Name can't be blank" => "Введите имя",
									"Phones can't be blank" => "Введите телефон",
									"Datestamp can't be blank" => "Выберите дату визита"
									}
end

get '/' do
	erb :index
end

get '/barber/:id' do
		@barber = Master.find params[:id]
		erb :barber
end

get '/bookings' do
	@bookings = Client.all
erb :bookings
end

get '/visit' do
		@c = Client.new
		erb :visit
end

post '/visit' do

	@c = Client.new params[:client]
	if @c.save
		erb "<div class='alert alert-success'>Thanks #{@c.name}! #{@c.barber} is waiting you at #{@c.datestamp}.</div>"
	else
		@error = "Ошибка. #{@errors_list[@c.errors.full_messages.first]}"
		erb :visit
	end
end

get '/contacts' do
	@cont = Contact.new
	erb :contacts
end

post '/contacts' do
	@cont = Contact.new params[:contact]
	if @cont.save
		erb "<div class='alert alert-success'>Thanks! We will answer you to #{@cont.email} soon.</div>"
	else
		@error = "Ошибка"
		erb :contacts
	end
end
