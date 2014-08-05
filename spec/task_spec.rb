require 'pg'
require 'rspec'
require 'task'
require 'spec_helper'
require 'pry'

RSpec.configure do |config|
  config.after(:each) do
    DB.exec("DELETE FROM tasks *;")
  end
end

describe Task do
  it 'is initialized with a name and a list ID' do
    task = Task.new('Learn SQL', 1)
    task.should be_an_instance_of Task
  end

  it 'reads tasks' do
    task = Task.new('Learn SQL', 1)
    expect(task.name).to eq 'Learn SQL'
  end

  it 'starts off with no tasks' do
    expect(Task.all).to eq []
  end

  it 'lets you save tasks to the database' do
    task = Task.new('Learn SQL', 1)
    task.save
    expect(Task.all).to eq [task]
  end

  it 'is the same task if it has the same name' do
    task1 = Task.new('learn SQL', 1)
    task2 = Task.new('learn SQL', 1)
    task1.should eq task2
  end

  it 'allows user to mark a task as done' do
    task1 = Task.new('learn SQL', 1)
    task1.save
    task1.marked_done
    expect(Task.all[0].done).to eq true
  end

  it 'allows user to enter a due date' do
    task = Task.new('learn SQL', 1)
    task.due_date = '2014-08-14'
    task.save
    expect(Task.all.first.due_date).to  eq '2014-08-14'
  end

  it 'lets you delete a task by name' do
    task = Task.new('Learn SQL', 1)
    task.save
    task2 = Task.new('Learn Postgres', 1)
    task2.save
    task.destroy_by_name
    expect(Task.all).to eq [task2]
  end

  describe '.destroy_by_list_id' do
    it 'lets you destroy all tasks by list_id' do
      task = Task.new("scrub zebra", 1)
      task2 = Task.new("scrub dog", 1)
      task3 = Task.new("eat pizza", 2)
      task.save
      task2.save
      task3.save
      Task.destroy_by_list_id(1)
      expect(Task.all).to eq [task3]
    end
  end

  describe '.search' do
    it 'lets you find an object in database given a task name' do
      task = Task.new('scrub the zebra', 1)
      task.save
      task2 = Task.new('scrub the chinchilla', 1)
      task2.save
      expect(Task.search('scrub the zebra')).to eq task
    end
  end
end
