require 'spec_helper'

describe '#initialize' do

  context 'with no available denominations' do
    it 'throws an error' do
      expect { CoinChanger.new([], 100) }.to raise_error
    end
  end

  context 'with one or more available denominations' do
    it 'does not throw an error' do
      expect { CoinChanger.new([0.01, 0.05, 0.10, 0.25], 100) }.to_not raise_error
    end
  end

  context 'with available denominations as floats and integers' do
    it 'does not throw an error' do
      expect { CoinChanger.new([0.01, 0.05, 0.10, 0.25, 5, 10], 100) }.to_not raise_error
    end
  end

  context 'with an unrecognized denomination' do
    it 'throws an error' do
      expect { CoinChanger.new([0.01, 0.05, 0.10, 0.35], 100) }.to raise_error
    end
  end

  context 'with an invalid maximum amount' do
    it 'throws an error' do
      expect { CoinChanger.new([0.01, 0.05, 0.10, 0.25], 'one hundred') }.to raise_error
    end
  end
end

describe '#get_change errors' do

  let(:change) {CoinChanger.new([20.00, 10.00, 5.00, 1.00, 0.25, 0.10, 0.05, 0.01], 100)}
  context 'input must be an integer' do
    it 'throws an error' do
      expect { change.get_change('12') }.to raise_error
    end
  end

  context 'input must be less than or equal to max_amount' do
    it 'throws an error' do
      expect { change.get_change(100.01) }.to raise_error
    end
  end

  context 'input must be greater than 0' do
    it 'throws an error' do
      expect { change.get_change(0) }.to raise_error
    end
  end

  context 'input cannot be negative' do
    it 'throws an error' do
      expect { change.get_change(-10) }.to raise_error
    end
  end
end

describe '#get_change' do
  array = [20, 10, 5.00, 1, 0.25, 0.10, 0.05, 0.01].shuffle
  let(:change) {CoinChanger.new(array, 100)}
  context 'returns correct change as an array' do
    it 'returns an array of three quarters' do
      change.get_change(0.75).should eq [0.25, 0.25, 0.25]
    end
  end

  context 'returns correct change as an array' do
    it 'returns an array of three quarters, two dimes, one penny' do
      change.get_change(0.955555555).should eq [0.25, 0.25, 0.25, 0.10, 0.10, 0.01]
    end
  end

  context 'returns correct change as an array' do
    it 'returns an array of one twenty, one dime, and one penny' do
      change.get_change(20.11).should eq [20.00, 0.10, 0.01]
    end
  end

  context 'returns correct change as an array' do
    it 'returns an array of one quarter and four pennies' do
      change.get_change(0.2944444441).should eq [0.25, 0.01, 0.01, 0.01, 0.01]
    end
  end

  context 'returns correct change as an array' do
    it 'returns an array of one five' do
      change.get_change(5).should eq [5.0]
    end
  end
end