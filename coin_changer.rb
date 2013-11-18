class CoinChanger

  attr_reader :valid_denominations, :max_amount_allowed, :available_denominations

  def initialize(available_denominations, max_amount_allowed)
    @valid_denominations = [100.00, 50.00, 20.00, 10.00, 5.00, 1.00, 0.25, 0.10, 0.05, 0.01]
    @max_amount_allowed = max_amount_allowed
    @available_denominations = available_denominations.sort
    raise ArgumentError, 'Max amount allowed must be numeric.' unless max_amount_allowed.is_a?(Numeric)
    validate_input(@available_denominations)
  end

  def validate_input(available_denominations)
    invalid_denominations = available_denominations.reject{ |value| valid_denominations.include?(value) }
    if available_denominations.empty?
      raise ArgumentError, 'There is no cash available to make change.'
    elsif !invalid_denominations.empty?
      invalid = invalid_denominations.first
      raise ArgumentError, "#{invalid} is not a valid denomination."
    end
  end

  def get_change(amount)
    raise ArgumentError, 'Input must be a numeric value.' unless amount.is_a?(Numeric)
    raise ArgumentError, "Change amount cannot be greater than #{max_amount_allowed}." unless amount <= max_amount_allowed
    change_total = amount = amount.round(2)
    output = []
    sum = 0
    value = available_denominations.pop
    until sum == change_total
      if (amount - value) >= 0
        output << value
        amount = (amount - value).round(2)
        sum = (output.reduce(:+)).round(2)
      else
        value = available_denominations.pop
      end
    end
    output
  end

end