ENV['SINATRA_ENV'] ||= 'development'
require 'bundler/setup'
Bundler.require(:default, ENV['SINATRA_ENV'])
Dotenv.load if ENV['SINATRA_ENV'] == development


# ActiveRecord::Base.establish_connection(
#   :adapter => "sqlite3",
#   :database => "db.sqlite"
# )
set :database_file, "./db.yml"
require_relative "../app/controllers/application_controller.rb"

Dir[File.join(File.dirname(__FILE__), "../app/models", "*.rb")].each {|f| require f}
Dir[File.join(File.dirname(__FILE__), "../app/controllers", "*.rb")].sort.each {|f| require f}
Dir[File.join(File.dirname(__FILE__), "../app/helpers", "*.rb")].sort.each {|f| require f}