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

get('/list/:id') do
  id = params.fetch("id").to_i()
  @list = List.all(id).pop()
  @tasks = Task.all(id)
  erb(:list)
end
