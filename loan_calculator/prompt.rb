# frozen_string_literal: true

require_relative 'localization'
require_relative 'convert_string'
require_relative 'invalid_numeric_error'

def show_prompt(message)
  puts "=> #{message}"
end

def numeric_valid?(numeric, require_positive, require_zero_plus)
  (require_positive ? numeric.positive? : true) &&
    (require_zero_plus ? numeric.zero? || numeric.positive? : true)
end

def invalid_numeric_message(numeric, require_positive, require_zero_plus)
  message = String.new

  message += MESSAGES['number_input_clarify_positive'] unless require_positive ? numeric.positive? : true
  unless require_zero_plus ? numeric.zero? || numeric.positive? : true
    message += "\n" if message.length.positive?
    message += MESSAGES['number_input_clarify_zero_plus']
  end
  message
end

def validate_numeric(numeric, require_positive, require_zero_plus)
  unless numeric_valid?(numeric, require_positive, require_zero_plus)
    raise InvalidNumericError,
          invalid_numeric_message(numeric, require_positive, require_zero_plus)
  end

  nil
end

def prompt_numeric(prompt, convert, require_positive: false, require_zero_plus: false)
  show_prompt(prompt)
  loop do
    float = convert.call(gets.strip)
    validate_numeric(float, require_positive, require_zero_plus)
    break float
  rescue InvalidNumericError => e
    show_prompt("#{e.message} #{prompt}")
  rescue StandardError
    show_prompt("#{MESSAGES['entry_invalid_message']} #{prompt}")
  end
end

def prompt_integer(prompt, require_positive: false, require_zero_plus: false)
  prompt_numeric(prompt, ConvertString.to_integer,
                 require_positive: require_positive,
                 require_zero_plus: require_zero_plus)
end

def prompt_float(prompt, require_positive: false, require_zero_plus: false)
  prompt_numeric(prompt, ConvertString.to_float,
                 require_positive: require_positive,
                 require_zero_plus: require_zero_plus)
end

# Return [years, months] with input like 5y 6m
def parse_loan_duration_input(input)
  years_match = /(\d+)\s*y/i.match(input)
  months_match = /(\d+)\s*m/i.match(input)

  [years_match.nil? ? 0 : ConvertString.to_integer.call(years_match[1]),
   months_match.nil? ? 0 : ConvertString.to_integer.call(months_match[1])]
end

def prompt_loan_duration
  prompt = MESSAGES['loan_duration_prompt']
  show_prompt(prompt)

  loop do
    input = gets.strip
    years, months = parse_loan_duration_input(input)
    break (years * 12) + months unless years.zero? && months.zero?

    show_prompt("#{MESSAGES['entry_invalid_message']} #{prompt}")
  rescue StandardError
    show_prompt("#{MESSAGES['entry_invalid_message']} #{prompt}")
  end
end
