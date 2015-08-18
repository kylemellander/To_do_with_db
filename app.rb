require('sinatra')
require('sinatra/reloader')
also_reload('lib/**/*.rb')
require('./lib/list')
require('./lib/task')
require('pg')

DB = PG.connect({:dbname => "to_do"})

get('/') do
  @lists = List.all()
  erb(:index)
end

post('/list/add') do
  name = params.fetch("name")
  List.new({:name => name}).save()
  @lists = List.all()
  @success_message = "#{name} was added."
  erb(:index)
end

get('/list/:list_id') do
  list_id = params.fetch("list_id").to_i()
  @list = List.all(list_id).pop()
  @tasks = Task.all(list_id)
  erb(:list)
end

post('/list/:list_id/task/add') do
  list_id = params.fetch("list_id").to_i
  description = params.fetch('description')
  Task.new({:description => description, :list_id => list_id}).save()
  @tasks = Task.all(list_id)
  @list = List.all(list_id).pop()
  @success_message = "Yay! More to do!"
  erb(:list)

end
