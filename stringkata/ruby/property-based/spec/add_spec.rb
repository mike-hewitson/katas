require_relative '../lib/add'
require 'rantly'
require 'rantly/rspec_extensions'
require 'rantly/shrinks'

include Add

puts Add.add_string('')

describe Add, '#add_string' do
  context 'given an empty string' do
    it 'it should return 0' do
      expect(Add.add_string('')).to eql(0)
    end
  end
  context 'given a single number' do
    it 'it should return the value' do
      property_of { range(0, 1_000) }.check do |i|
        expect(Add.add_string(i.to_s)).to eql(i)
      end
    end
  end
  context 'given a comma seperated list of numbers' do
    it 'it should return the sum' do
      property_of { array(10) { range(0, 1_000) } }.check do |array|
        sum = array.inject(:+)
        string = array.join(',')
        expect(Add.add_string(string)).to eql(sum)
      end
    end
  end
  context 'given a comma or nl seperated list of numbers' do
    it 'it should return the sum' do
      property_of { [array(10) { range(0, 1_000) }, choose(',', "\n")] }
        .check do |(array, delim)|
        sum = array.inject(:+)
        string = array.join(delim)
        expect(Add.add_string(string)).to eql(sum)
      end
    end
  end
  context 'given a specific delimiter seperated list of numbers' do
    it 'it should return the sum' do
      property_of {
        delim = Rantly { sized(1) { string(:alpha) } }
        [array(10) { range(0, 1_000) }, delim]
      }.check do |(array, delim)|
        sum = array.inject(:+)
        string = array.join(delim)
        string = "//#{delim}\n" + string
        expect(Add.add_string(string)).to eql(sum)
      end
    end
  end
  context 'given a specific delimiter seperated list of numbers with negatives' do
    it 'it should raise an exception and list the negatives' do
      property_of {
        delim = Rantly { sized(1) { string(:alpha) } }
        [array(10) { range(-100_000, 0) }, delim]
      }.check do |(array, delim)|
        negatives = array.select { |n| n < 0 }.map(&:to_s).join
        string = array.join(delim)
        string = "//#{delim}\n" + string
        expect { Add.add_string(string) }.to raise_error(ArgumentError, negatives)
      end
    end
  end
  context 'given a specific delimiter seperated list of numbers' do
    it 'it should return the sum ignoring > 1_000' do
      property_of {
        delim = Rantly { sized(1) { string(:alpha) } }
        [array(10) { range(995, 1_005) }, delim]
      }.check do |(array, delim)|
        sum = array.select{ |n| n < 1_001 }.inject(:+)
        string = array.join(delim)
        string = "//#{delim}\n" + string
        expect(Add.add_string(string)).to eql(sum)
      end
    end
  end
end
