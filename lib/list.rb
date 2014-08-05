require 'pg'

class List

  attr_accessor :name, :id

  def initialize(name, id=nil)
    @name = name
    @id = id
  end

  def save
    results = DB.exec("INSERT INTO lists (name) VALUES ('#{@name}') RETURNING id;")
    @id = results.first['id'].to_i
  end

  def ==(another_list)
    self.name == another_list.name && self.id == another_list.id
  end

  def self.all
    results = DB.exec("SELECT * FROM lists;")
    lists = []
    results.each do |result|
      name = result['name']
      id = result['id'].to_i
      lists << List.new(name, id)
    end
    lists
  end

  def self.search_by_name(description)
    found = List.all.find { |list| list.name == description }
  end

  def tasks(list_id)
    list_found = List.all.find { |list| self.id == list_id}
    results = DB.exec("SELECT * FROM tasks WHERE list_id = #{list_id};")
    tasks = []
    results.each do |task|
      name = task['name']
      list_id = task['list_id'].to_i
      tasks << Task.new(name, list_id)
    end
    tasks
  end

  def destroy
    DB.exec("DELETE FROM lists WHERE name = ('#{@name}');")
  end
end
