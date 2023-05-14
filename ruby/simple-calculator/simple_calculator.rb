class SimpleCalculator
  ALLOWED_OPERATIONS = ['+', '/', '*'].freeze

  class UnsupportedOperation < StandardError
  end

  def self.calculate(first_operand, second_operand, operation)
    raise UnsupportedOperation unless ALLOWED_OPERATIONS.include?(operation)
    raise ArgumentError unless first_operand.is_a?(Integer) && second_operand.is_a?(Integer)

    result = case operation
             when '+'
               first_operand + second_operand
             when '*'
               first_operand * second_operand
             when '/'
               begin
                 first_operand / second_operand
               rescue ZeroDivisionError => _e
                 return 'Division by zero is not allowed.'
               end
             end

    "#{first_operand} #{operation} #{second_operand} = #{result}"
  end
end
