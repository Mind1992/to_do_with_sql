require 'pg'
require './lib/task'

DB = PG.connect({:dbname => 'to_do'})

def main_menu
  loop do
    puts "***Welcome to the To Do list!***"
    puts "1: add task"
    puts "2: list all tasks"
    puts "3: delete task"
    puts "9: exit"
    puts "\n"
    print ">"
    user_input = gets.chomp
    case user_input
      when '1' then add_task
      when '2' then list_all_tasks
      when '9' then exit
    end
  end
end

def list_all_tasks
  puts "Your tasks are:\n"
  Task.all.each { |task| puts task.name }
  puts "\n"
end

def add_task
  print "New task: "; new_task = gets.chomp
  Task.new(new_task).save
  test = DB.exec("SELECT * FROM tasks;")
end

main_menu
