
require 'rubygems'
require 'bundler/setup'
Bundler.require
require './models/TodoItem'

ActiveRecord::Base.establish_connection(
  :adapter  => 'sqlite3',
  :database => 'db/development.db',
  :encoding => 'utf8'
)

get '/' do
  @tasks = TodoItem.all.order(:due)
  erb :form
end

post '/' do
  TodoItem.create(description: params[:task], due: params[:date])
  redirect '/'
end

helpers do
  def nodate(x)
    x.nil? || x == ""
  end
end