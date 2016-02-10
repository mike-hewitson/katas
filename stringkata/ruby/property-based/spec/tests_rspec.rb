require_relative '../add.rb'
require 'rantly'
require 'rantly/rspec_extensions'
require 'rantly/shrinks'

include Add
# require 'rspec'

puts Add.add_string('')

describe Add, '#add_string' do
  context 'given an empty string' do
    it 'it should return 0' do
      expect(Add.add_string('')).to eql(0)
    end
  end
  context 'given a single number' do
    it 'it should return the value' do
      property_of {
        integer
      }.check do |i|
        expect(Add.add_string(i.to_s)).to eql(i)
      end
    end
  end
  context 'given a comma seperated list of numbers' do
    it 'it should return the sum' do
      property_of {
        Rantly { array(10) { integer } }
      }.check do |array|
        sum = array.inject(:+)
        string = array.join(',')
        expect(Add.add_string(string)).to eql(sum)
      end
    end
  end
  context 'given a comma or nl seperated list of numbers' do
    it 'it should return the sum' do
      property_of {
        Rantly { array(10) { integer } }
      }.check do |array|
        sum = array.inject(:+)
        string = array.join(',')
        expect(Add.add_string(string)).to eql(sum)
      end
    end
  end
end
