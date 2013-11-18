class CoinChanger

  attr_reader :denominations

  def initialize(denominations)
    @denominations = denominations
    validate_input(@denominations)
  end

  def validate_input(denominations)
    valid_denominations = [1, 5, 10, 25, 100, 500, 1000, 2000]
    invalid_denominations = denominations.reject{ |value| valid_denominations.include?(value) }
    if denominations.empty?
      raise 'There are no denominations available to make change.'
    elsif !invalid_denominations.empty?
      invalid = invalid_denominations.first
      raise "#{invalid} is not a valid denomination."
    end
  end

  def get_change(amount)
    raise 'Input must be a numeric value.' unless amount.is_a?(Numeric)

  end

end