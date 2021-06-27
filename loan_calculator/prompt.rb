# frozen_string_literal: true

require_relative 'localization'
require_relative 'convert_string'
require_relative 'numeric_invalid_error'

def prompt(message)
  puts "=> #{message}"
end

def numeric_valid?(numeric, require_positive, require_zero_plus)
  (require_positive ? numeric.positive? : true) &&
    (require_zero_plus ? numeric.zero? || numeric.positive? : true)
end

def numeric_invalid_message(numeric, require_positive, require_zero_plus)
  message = String.new

  message += MESSAGES['number_input_clarify_positive'] unless require_positive ? numeric.positive? : true
  unless require_zero_plus ? numeric.zero? || numeric.positive? : true
    message += "\n" if message.length.positive?
    message += MESSAGES['number_input_clarify_zero_plus']
  end
  message
end

def numeric_validate(numeric, require_positive, require_zero_plus)
  unless numeric_valid?(numeric, require_positive, require_zero_plus)
    raise NumericInvalidError,
          numeric_invalid_message(numeric, require_positive, require_zero_plus)
  end

  nil
end

def numeric_prompt(prompt, convert, require_positive: false, require_zero_plus: false)
  prompt(prompt)
  loop do
    numeric = convert.call(gets.strip)
    numeric_validate(numeric, require_positive, require_zero_plus)
    break numeric
  rescue NumericInvalidError => e
    prompt("#{e.message} #{prompt}")
  rescue StandardError
    prompt("#{MESSAGES['entry_invalid_message']} #{prompt}")
  end
end

def integer_prompt(prompt, require_positive: false, require_zero_plus: false)
  numeric_prompt(prompt, ConvertString.to_integer,
                 require_positive: require_positive,
                 require_zero_plus: require_zero_plus)
end

def float_prompt(prompt, require_positive: false, require_zero_plus: false)
  numeric_prompt(prompt, ConvertString.to_float,
                 require_positive: require_positive,
                 require_zero_plus: require_zero_plus)
end

# Return [years, months] with input like 5y 6m
def loan_duration_input_parse(input)
  years_match = /(\d+)\s*y/i.match(input)
  months_match = /(\d+)\s*m/i.match(input)

  [years_match.nil? ? 0 : ConvertString.to_integer.call(years_match[1]),
   months_match.nil? ? 0 : ConvertString.to_integer.call(months_match[1])]
end

def loan_duration_prompt
  prompt = MESSAGES['loan_duration_prompt']
  prompt(prompt)

  loop do
    input = gets.strip
    years, months = loan_duration_input_parse(input)
    break (years * 12) + months unless years.zero? && months.zero?

    prompt("#{MESSAGES['entry_invalid_message']} #{prompt}")
  rescue StandardError
    prompt("#{MESSAGES['entry_invalid_message']} #{prompt}")
  end
end
