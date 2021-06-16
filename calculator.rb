# frozen_string_literal: true

# ask the user for two numbers
# ask the user for the prompt_operation to perform on those numbers
# perform the prompt_operation on the two numbers
# output the result

# answer = Kernel.gets
# Kernel.puts(answer)

def show_message(message)
  Kernel.puts("=> #{message}")
end

def prompt_name
  show_message("What's your name?")

  loop do
    name = gets.strip

    break name unless name.empty?

    show_message('Please enter a name. You can use a fake one if you wish.')
  end
end

def number?(number)
  true if Float(number)
rescue ArgumentError
  false
rescue StandardError => e
  raise e
end

def prompt_number(message)
  show_message(message)

  loop do
    number = Kernel.gets.strip
    break number.to_f if number?(number)

    show_message("That's not a valid number. Please try again.")
  end
end

def operation_prompt_message
  <<~MSG
    What's the operation?
    1) add
    2) subtract
    3) multiply
    4) divide
  MSG
end

def prompt_operation
  show_message(operation_prompt_message)

  loop do
    operation = Kernel.gets.strip

    break operation if %w[1 2 3 4].include?(operation)

    show_message('Please enter a valid operation: 1, 2, 3, or 4')
  end
end

def calculate(number1, number2, operation)
  case operation
  when '1' then number1 + number2
  when '2' then number1 - number2
  when '3' then number1 * number2
  when '4' then number1 / number2
  end
end

show_message('Welcome to Calculator!')
show_message("Hello, #{prompt_name} :-)\n\n")

loop do
  result = calculate(prompt_number("What's the first number?"),
                     prompt_number("What's the second number?"),
                     prompt_operation)
  result = result.to_i if result.modulo(1).zero?

  show_message("Result: #{result}\n\n")
  show_message("Type 'y' to perform another operation, or enter to quit.")
  continue = gets.chomp.strip.downcase
  break if continue != 'y'
end
