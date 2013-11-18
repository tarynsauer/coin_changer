require 'spec_helper'

describe '#initialize' do

  context 'with no available denominations' do
    it 'throws an error' do
      expect { CoinChanger.new([]) }.to raise_error
    end
  end

  context 'with one or more available denominations' do
    it 'does not throw an error' do
      expect { CoinChanger.new([1, 5, 10, 25]) }.to_not raise_error
    end
  end

  context 'with an unrecognized denomination' do
    it 'throws an error' do
      expect { CoinChanger.new([1, 5, 10, 35]) }.to raise_error
    end
  end
end

describe '#get_change errors' do

  context 'input must be an integer' do
    it 'throws an error' do
      change = CoinChanger.new([1, 5, 10, 25, 100, 500, 1000, 2000])
      expect { change.get_change('12') }.to raise_error
    end
  end
end

describe '#get_change' do


end