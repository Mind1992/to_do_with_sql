require 'pg'
require 'rspec'
require 'task'
require 'spec_helper'

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

  it 'lets you delete a task' do
    task = Task.new('Learn SQL', 1)
    task.save
    task2 = Task.new('Learn Postgres', 1)
    task2.save
    task.destroy
    expect(Task.all).to eq [task2]
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
