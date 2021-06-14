require "./config/environment"
require "sinatra/activerecord/rake"
task default: [:start]

task :start do
  "Starting the project!"
  rake db:migrate
  rake db:seed
end