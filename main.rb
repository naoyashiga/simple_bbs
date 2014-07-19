# encoding: utf-8
require 'sinatra'
require 'sinatra/reloader'
require 'active_record'

ActiveRecord::Base.establish_connection(
	"adapter" => "sqlite3",
	"database" => "./bbs.db"
)

helpers do
	include Rack::Utils
	alias_method :h, :escape_html
end

class Comment < ActiveRecord::Base

end

get "/" do
	@comments = Comment.order("id desc").all
	@title = "10文字掲示板"
	erb :index
end

post "/new" do
	Comment.create({
		:name => params[:name],
		:body => params[:body],
		:date_time => Time.now.strftime("%Y-%m-%d %H:%M:%S")
		})
	redirect "/"
end

post "/delete" do
	Comment.find(params[:id]).destroy
end

