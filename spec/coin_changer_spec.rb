require 'spec_helper'

describe '#initialize' do

  context 'with no available denominations' do
    it 'throws an error' do
      expect { CoinChanger.new([], 100) }.to raise_error(ArgumentError)
    end
  end

  context 'with one or more available denominations' do
    it 'does not throw an error' do
      expect { CoinChanger.new([0.01, 0.05, 0.10, 0.25], 100) }.to_not raise_error(ArgumentError)
    end
  end

  context 'with an unrecognized denomination' do
    it 'throws an error' do
      expect { CoinChanger.new([0.01, 0.05, 0.10, 0.35], 100) }.to raise_error(ArgumentError)
    end
  end
end

describe '#get_change errors' do

  let(:change) {CoinChanger.new([20.00, 10.00, 5.00, 1.00, 0.25, 0.10, 0.05, 0.01], 100)}
  context 'input must be an integer' do
    it 'throws an error' do
      expect { change.get_change('12') }.to raise_error(ArgumentError)
    end
  end

  context 'input must be less than or equal to max_amount' do
    it 'throws an error' do
      expect { change.get_change(100.01) }.to raise_error(ArgumentError)
    end
  end
end

describe '#get_change' do

  let(:change) {CoinChanger.new([20.00, 10.00, 5.00, 1.00, 0.25, 0.10, 0.05, 0.01], 100)}
  context 'returns correct change as an array' do
    it 'returns an array of three quarters' do
      result = change.get_change(0.75)
      result.should eq [0.25, 0.25, 0.25]
    end
  end
end