require 'pg'

class Task

  attr_accessor :name

  def initialize(name)
    @name = name
  end

  def self.all
   results = DB.exec("SELECT * FROM tasks;")
   tasks = []
   results.each do |result|
    name = result['name']
    tasks << Task.new(name)
  end
  tasks
  end

  def save
    DB.exec("INSERT INTO tasks (name) VALUES ('#{@name}');")
  end

  def destroy
    DB.exec("DELETE FROM tasks WHERE name = ('#{@name}');")
  end

  def ==(another_task)
    self.name == another_task.name
  end

  def self.search(description)
    found = Task.all.find { |task| task.name == description }
  end
end


