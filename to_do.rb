require 'pg'
require './lib/task'

DB = PG.connect({:dbname => 'to_do'})

def welcome
  puts "Welcome to the To Do list!"
  menu
end
