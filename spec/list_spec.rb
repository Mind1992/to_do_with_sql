require 'rspec'
require 'list'
require 'pg'

DB = PG.connect({:dbname => 'to_do_test_js'})

RSpec.configure do |config|
  config.after(:each) do
    DB.exec("DELETE FROM lists *;")
  end
end

describe List do
  it 'is initialized by a name' do
    list = List.new('Clean')
    expect(list).to be_an_instance_of List
  end

  it 'lets you read its name' do
    list = List.new('Clean')
    expect(list.name).to eq 'Clean'
  end
end
