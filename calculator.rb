# frozen_string_literal: true

# ask the user for two numbers
# ask the user for the operation to perform on those numbers
# perform the operation on the two numbers
# output the result

# answer = Kernel.gets
# Kernel.puts(answer)

def prompt(message)
  Kernel.puts("=> #{message}")
end

prompt('Welcome to Calculator!')

prompt("What's the first number? ")
number1 = Kernel.gets.strip.to_f

prompt("What's the second number? ")
number2 = Kernel.gets.strip.to_f

prompt("What's the operation?\nadd: 1 | subtract: 2 | multiply: 3 | divide: 4")
operator = Kernel.gets.strip

result = case operator
         when '1' then number1 + number2
         when '2' then number1 - number2
         when '3' then number1 * number2
         when '4' then number1 / number2
         end

result = result.to_i if result.modulo(1).zero?

Kernel.puts("Result: #{result}")
