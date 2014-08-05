require 'pg'
require './lib/task'
require './lib/list'

DB = PG.connect({:dbname => 'to_do_js'})

def main_menu
  loop do
    puts "***Welcome to the To Do list!***"
    puts "1: add a list"
    puts "2: add a task to a list"
    puts "3: list all tasks for a list"
    puts "4: delete a task"
    puts "5: delete a list and all of its tasks"
    puts "9: exit"
    puts "\n"
    print ">"
    user_input = gets.chomp
    case user_input
      when '1' then add_list
      when '2' then add_task
      when '3' then list_all_tasks
      when '4' then delete_task
      when '5' then delete_list
      when '9' then exit
    end
  end
end

def add_list
  print "New list: "; new_list = gets.chomp
  List.new(new_list).save
  puts "*#{new_list}* added"
end

def add_task
  puts "Select a list:"
  List.all.each { |list| puts list.name }
  print ">"
  list = gets.chomp
  found_list = List.search_by_name(list)
  print "New task: ";
  print ">"; new_task = gets.chomp
  task_added = Task.new(new_task, found_list.id).save
  puts "The tasks #{new_task} has been added."
end

def list_all_lists
  puts "Select a list:"
  List.all.each { |list| puts list.name }
  print ">"
  list = gets.chomp
  found_list = List.search_by_name(list)
  puts "Your tasks are:\n"
  puts "\n"
  found_list.tasks(found_list.id).each { |task| puts task.name }
  puts "\n"
end

def delete_task
  puts "Here are all the lists: "
  List.all.each { |list| puts list.name }
  print "Type in the list name: "; choosen_list = gets.chomp
  searched_list = List.search_by_name(choosen_list)
  searched_list.tasks(searched_list.id).each do |task|
    puts task.name
    puts "\n"
  end
  print "Type in the task name: "; user_input = gets.chomp
  searched_task = Task.search(user_input)
  searched_task.destroy_by_name
  puts "#{user_input} was deleted"
  if searched_list.tasks.length > 0
    puts searched_list.tasks(searched_list.id)
  else
    puts "There are no tasks in the #{searched_list.name} list!"
  end
end

def delete_list_and_tasks

end

def delete_list
  list_all_lists
  print "Type in the list name: "; user_input = gets.chomp
  searched_list = List.search_by_name(user_input)
  searched_list.destroy
  puts "#{user_input} list was deleted"
  puts list_all_lists
end

main_menu
