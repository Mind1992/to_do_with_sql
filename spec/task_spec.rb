require 'pg'
require 'rspec'
require 'task'

DB = PG.connect({:dbname => 'to_do_test'})

RSpec.configure do |config|
  config.after(:each) do
    DB.exec("DELETE FROM tasks *;")
  end
end

describe Task do
  it 'reads tasks' do
    task = Task.new('Learn SQL')
    expect(task.name).to eq 'Learn SQL'
  end

  it 'starts off with no tasks' do
    expect(Task.all).to eq []
  end

  it 'lets you save tasks to the database' do
    task = Task.new('Learn SQL')
    task.save
    expect(Task.all).to eq [task]
  end

  it 'is the same task if it has the same name' do
    task1 = Task.new('learn SQL')
    task2 = Task.new('learn SQL')
    task1.should eq task2
  end
end
