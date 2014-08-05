require 'pg'

class Task

  attr_accessor :name, :list_id

  def initialize(name, list_id)
    @name = name
    @list_id = list_id
  end

  def self.all
   results = DB.exec("SELECT * FROM tasks;")
   tasks = []
   results.each do |result|
    name = result['name']
    list_id = result['list_id'].to_i
    tasks << Task.new(name, list_id)
  end
  tasks
  end

  def save
    DB.exec("INSERT INTO tasks (name, list_id) VALUES ('#{@name}', #{@list_id});")
  end

  def destroy_by_name
    DB.exec("DELETE FROM tasks WHERE name = ('#{@name}');")
  end

  def ==(another_task)
    self.name == another_task.name && self.list_id == another_task.list_id
  end

  def self.search(description)
    found = Task.all.find { |task| task.name == description }
  end

  def self.destroy_by_list_id(number)
    DB.exec("DELETE FROM tasks WHERE list_id = ('#{number}');")
  end
end


