# frozen_string_literal: true

require_relative 'localization'

def show_prompt(message)
  puts "=> #{message}"
end

def string_to_integer(string)
  Integer(string)
end

def string_to_float(string)
  Float(string)
end

def numeric_valid?(numeric, require_positive, require_zero_plus)
  (require_positive ? numeric.positive? : true) &&
    (require_zero_plus ? numeric.zero? || numeric.positive? : true)
end

def numeric_invalid_explanation(numeric, require_positive, require_zero_plus)
  message = String.new

  message += MESSAGES['number_input_clarify_positive'] if require_positive ? numeric.positive? : false
  if require_zero_plus ? numeric.zero? || numeric.positive? : false
    message += "\n" if message.length.positive?
    message += MESSAGES['number_input_clarify_zero_plus']
  end

  message
end

def numeric_valid_with_explanation?(numeric, require_positive, require_zero_plus)
  return true if numeric_valid?(numeric, require_positive, require_zero_plus)

  puts numeric_invalid_explanation(numeric, require_positive, require_zero_plus)
  false
end

def prompt_integer(prompt, require_positive: false, require_zero_plus: false)
  show_prompt(prompt)
  loop do
    integer = string_to_integer(gets.strip)
    next unless numeric_valid_with_explanation?(integer, require_positive, require_zero_plus)

    break integer
  rescue StandardError
    show_prompt("#{MESSAGES['entry_invalid_message']} #{prompt}")
  end
end

def prompt_float(prompt, require_positive: false, require_zero_plus: false)
  show_prompt(prompt)
  loop do
    float = string_to_float(gets.strip)
    next unless numeric_valid_with_explanation?(float, require_positive, require_zero_plus)

    break float
  rescue StandardError
    show_prompt("#{MESSAGES['entry_invalid_message']} #{prompt}")
  end
end

# Return [years, months] with input like 5y 6m
def duration_input_to_months(input)
  years_match = /(\d+)y/.match(input)
  months_match = /(\d+)m/.match(input)

  [years_match.nil? ? 0 : string_to_integer(years_match[1]),
   months_match.nil? ? 0 : string_to_integer(months_match[1])]
end

def prompt_loan_duration_months
  prompt = MESSAGES['loan_duration_prompt']
  show_prompt(prompt)

  loop do
    input = gets.strip
    years, months = duration_input_to_months(input)
    break (years * 12) + months unless years.zero? && months.zero?

    show_prompt("#{MESSAGES['entry_invalid_message']} #{prompt}")
  rescue StandardError
    show_prompt("#{MESSAGES['entry_invalid_message']} #{prompt}")
  end
end
