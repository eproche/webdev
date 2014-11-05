
require 'rubygems'
require 'bundler/setup'
Bundler.require
require './models/TodoItem'
require './models/UserTodoItem'

if ENV['DATABASE_URL']
  ActiveRecord::Base.establish_connection(ENV['DATABASE_URL'])
else
  ActiveRecord::Base.establish_connection(
    :adapter  => 'sqlite3',
    :database => 'db/development.db',
    :encoding => 'utf8'
  )
end

get '/' do
  @tasks = UserTodoItem.all.order(:due)
  erb :form
end

post '/' do
  UserTodoItem.create(description: params[:task], due: params[:date],
  user_id: params[:user_data]) 
  redirect '/'
end

post '/' do
  del_user_data = params[:delete_user_data]
  user_tasks = UserTodoItem.find_by(user_id: del_user_data) 
  some_id = user_tasks.id 
  UserTodoItem.find(some_id).destroy
  redirect '/'
end

helpers do
  def nodate(x)
    x.nil? || x == ""
  end
end