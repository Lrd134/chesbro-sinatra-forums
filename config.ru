require './config/environment'
use Rack::MethodOverride
use PostController
use UserController
use RepliesController
use CategoriesController
run ApplicationController