require 'rspec'

class CoinChanger

  def change(amount)
    change_output = []
    until amount == 0
      [25, 10, 5, 1].each do |coin|
        while amount >= coin
          change_output << coin
          amount -= coin
        end
      end
    end
    change_output
  end

end


describe CoinChanger do
  it 'returns the correct change' do
    changer = CoinChanger.new
    [
      [1, [1]],
      [2, [1,1]],
      [5, [5]],
      [6, [5,1]],
      [10, [10]],
      [29, [25,1,1,1,1]],
      [97, [25,25,25,10,10,1,1]]
    ].each do |input, expected|
      changer.change(input).should == expected
    end
  end
end

# # Transformation Priority Premise
# # Absolute Priority Premise
# # Three Rules of TDD