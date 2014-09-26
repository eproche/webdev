
require 'rubygems'
require 'bundler/setup'
Bundler.require

get '/' do
  lines = File.read("todo.txt").split("\n")
  @tasks = []
  lines.each do |line|
    task, date = line.split("-")
    @tasks << [task, date]
  end
  erb :form
end

post '/' do
  File.open("todo.txt", "a") do |file|
    unless nodate params[:date]
      file.puts "#{params[:task]} -- #{params[:date]}" 
    else
      file.puts "#{params[:task]}"
    end
  end
  redirect '/'
end

post '/formpage' do
  'Nice!!!!!!!!!!!!!            
  You can click the back button now if you want'
end

helpers do
  def nodate(x)
    x.nil? || x == ""
  end
end