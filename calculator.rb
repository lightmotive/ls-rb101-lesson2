# frozen_string_literal: true

# ask the user for two numbers
# ask the user for the prompt_operation to perform on those numbers
# perform the prompt_operation on the two numbers
# output the result

# answer = Kernel.gets
# Kernel.puts(answer)

operations = {
  '1': ['add', 'adding', :+],
  '2': ['subtract', 'subtracting', :-],
  '3': ['multiply', 'multiplying', :*],
  '4': ['divide', 'dividing', :/]
}

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

def operation_prompt_message(operations)
  String.new("What's the operation?") + operations.map { |k, v| "\n#{k}) #{v[0]}" }.reduce(&:+)
end

def prompt_operation(operations)
  show_message(operation_prompt_message(operations))

  loop do
    input = Kernel.gets.strip

    break operations[input.to_sym] if operations.key?(input.to_sym)

    show_message('Please enter a valid operation from the choices above.')
  end
end

def calculate(number1, number2, operation)
  puts "\n"
  show_message("#{operation[1].capitalize} #{number1} and #{number2}...")
  number1.send(operation[2], number2)
end

show_message('Welcome to Calculator!')
show_message("Hello, #{prompt_name} :-)\n\n")

loop do
  result = calculate(prompt_number("What's the first number?"),
                     prompt_number("What's the second number?"),
                     prompt_operation(operations))
  result = result.to_i if result.modulo(1).zero?

  show_message("Result: #{result}\n\n")
  show_message("Type 'y' to perform another operation, or enter to quit.")
  continue = gets.strip.downcase
  break if continue != 'y'
end
