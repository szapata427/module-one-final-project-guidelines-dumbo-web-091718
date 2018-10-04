require 'bundler'
Bundler.require
require 'io/console'
require 'colorize'
# require 'titleize'



ActiveRecord::Base.establish_connection(adapter: 'sqlite3', database: 'db/development.db')
require_all 'lib'
require_all 'models'
