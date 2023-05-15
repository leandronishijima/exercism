# Write your code for the 'Resistor Color Duo' exercise in this file. Make the tests in
# `resistor_color_duo_test.rb` pass.
#
# To get started with TDD, see the `README.md` file in your
# `ruby/resistor-color-duo` directory.
class ResistorColorDuo
  def self.value(resistors)
    resistors
      .take(2)
      .map { |resistor| get_value(resistor) }
      .join
      .to_i
  end

  def self.get_value(color)
    case color
    when 'black'
      '0'
    when 'brown'
      '1'
    when 'red'
      2
    when 'orange'
      3
    when 'yellow'
      4
    when 'green'
      5
    when 'blue'
      6
    when 'violet'
      7
    when 'grey'
      8
    when 'white'
      9
    end
  end
end
