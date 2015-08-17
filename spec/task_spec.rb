require("rspec")
require("pg")
require("task")

DB = PG.connect({:dbname => 'to_do_test'})

Rspec.configure do |config|
  config.after(:each) do

    DB.exec("DELETE FROM tasks *;")
  end
end

describe(Task) do
  ####
end
