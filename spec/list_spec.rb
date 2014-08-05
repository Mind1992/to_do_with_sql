require 'rspec'
require 'list'
require 'pg'
require 'spec_helper'

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

  it 'is the same list if it has the same name' do
    list1 = List.new('Clean')
    list2 = List.new('Clean')
    expect(list1).to eq list2
  end

  it 'lets you save lists' do
    list1 = List.new('Clean')
    list1.save
    expect(List.all).to eq [list1]
  end

  it 'lets you have multiple lists' do
    list1 = List.new('Clean')
    list2 = List.new('Epicodus stuff')
    list1.save
    list2.save
    expect(List.all).to eq [list1,list2]
  end

  it 'sets its ID when you save it' do
    list = List.new('learn SQL')
    list.save
    expect(list.id).to be_an_instance_of Fixnum
  end
end
