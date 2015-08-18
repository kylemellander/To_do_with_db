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
  erb(:index)
end
