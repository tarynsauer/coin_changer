class CoinChanger

  attr_reader :valid_denominations, :max_amount, :available_denominations

  def initialize(available_denominations, max_amount)
    @valid_denominations = [20.00, 10.00, 5.00, 1.00, 0.25, 0.10, 0.05, 0.01]
    @max_amount = max_amount
    @available_denominations = available_denominations
    validate_input(@available_denominations)
  end

  def validate_input(available_denominations)
    invalid_denominations = available_denominations.reject{ |value| valid_denominations.include?(value) }
    if available_denominations.empty?
      raise ArgumentError, 'There are no denominations available to make change.'
    elsif !invalid_denominations.empty?
      invalid = invalid_denominations.first
      raise ArgumentError, "#{invalid} is not a valid denomination."
    end
  end

  def get_change(amount)
    raise ArgumentError, 'Input must be a numeric value.' unless amount.is_a?(Numeric)
    raise ArgumentError, "Change amount cannot be greater than #{max_amount}." unless amount <= max_amount
    total = amount = amount.round(2)
    output = []
    sum = 0
    value = valid_denominations.shift
    until sum == total
      if (amount - value) >= 0
        output << value
        amount = (amount - value).round(2)
        sum = output.reduce(:+)
        sum = sum.round(2)
      else
        value = valid_denominations.shift
      end
    end
    output
  end

end

# change = CoinChanger.new([20.00, 10.00, 5.00, 1.00, 0.25, 0.10, 0.05, 0.01], 100)
# p change.get_change(0.75)