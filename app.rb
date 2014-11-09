
require 'rubygems'
require 'bundler/setup'
Bundler.require
require './models/TodoItem'

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
  @tasks = TodoItem.all.order(:due)
  erb :form
end

post '/' do
  TodoItem.create(description: params[:task], due: params[:date])
  redirect '/'
end

post '/delete' do
  some_id = TodoItem.where(description: params[:del_task]).limit(1).pluck(:id)
  TodoItem.destroy(some_id)
  redirect '/'
end

helpers do
  def nodate(x)
    x.nil? || x == ""
  end
end