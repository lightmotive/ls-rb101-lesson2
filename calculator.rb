# frozen_string_literal: true

require 'bigdecimal'
require 'yaml'

# ask the user for two numbers
# ask the user for the prompt_operation to perform on those numbers
# perform the prompt_operation on the two numbers
# output the result

MESSAGES = YAML.load_file('calculator_messages.yml')

operations = {
  '1': [MESSAGES['operation_add'], MESSAGES['operation_verb_add'], :+],
  '2': [MESSAGES['operation_subtract'], MESSAGES['operation_verb_subtract'], :-],
  '3': [MESSAGES['operation_multiply'], MESSAGES['operation_verb_multiply'], :*],
  '4': [MESSAGES['operation_divide'], MESSAGES['operation_verb_divide'], :/]
}

def show_message(message, separate: false)
  print "\n" if separate
  Kernel.puts("=> #{message}")
end

def prompt_name
  show_message(MESSAGES['name_prompt'])

  loop do
    name = gets.strip
    break name unless name.empty?

    show_message(MESSAGES['name_prompt_clarify'])
  end
end

def number?(number)
  true if BigDecimal(number)
rescue ArgumentError
  false
rescue StandardError => e
  raise e
end

def prompt_number(message)
  show_message(message)

  loop do
    number = Kernel.gets.strip
    break number if number?(number)

    show_message(MESSAGES['number_prompt_clarify'])
  end
end

def prompt_operation_message(operations)
  String.new(MESSAGES['operation_prompt']) + operations.map { |k, v| "\n#{k}) #{v[0]}" }.reduce(&:+)
end

def prompt_operation(operations)
  show_message(prompt_operation_message(operations))

  loop do
    input = Kernel.gets.strip
    break operations[input.to_sym] if operations.key?(input.to_sym)

    show_message(MESSAGES['operation_prompt_clarify'])
  end
end

def string_to_number(string)
  BigDecimal(string)
end

def show_calculating_message(operation, number_string1, number_string2)
  show_message("#{operation[1].capitalize} #{number_string1} and #{number_string2}...")
end

def calculate(number1, number2, operation)
  number1.send(operation[2], number2)
end

def simplify_result(result)
  return result.to_i if result == result.to_i
  # rubocop:disable Lint/FloatComparison
  return result.to_f if result == result.to_f
  # rubocop:enable Lint/FloatComparison

  result
rescue FloatDomainError
  result
end

show_message(MESSAGES['welcome_message'])
name = prompt_name
show_message("#{MESSAGES['greeting_prefix']} #{name} #{MESSAGES['greeting_suffix']}", separate: true)
# TODO: add a templating system to increase greeting flexibility.
print "\n"

loop do
  input1 = prompt_number(MESSAGES['number1_prompt'])
  input2 = prompt_number(MESSAGES['number2_prompt'])
  operation = prompt_operation(operations)
  show_calculating_message(operation, input1, input2)

  result = calculate(string_to_number(input1),
                     string_to_number(input2),
                     operation)

  show_message("#{MESSAGES['message_result_header']} #{simplify_result(result)}", separate: true)
  show_message(MESSAGES['continue_prompt'])
  continue = gets.strip.downcase
  break if continue != MESSAGES['continue_prompt_char_yes']
end
