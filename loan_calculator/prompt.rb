# frozen_string_literal: true

require_relative 'localization'
require_relative 'convert_string'
require_relative '../../ruby-common/validation_error'
require_relative '../../ruby-common/prompt'

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

def numeric_prompt(prompt, convert, require_positive: false, require_zero_plus: false)
  prompt_until_valid(
    prompt,
    get_input: -> { gets.strip }, convert_input: ->(input) { convert.call(input) },
    validate: lambda do |numeric|
      unless numeric_valid?(numeric, require_positive, require_zero_plus)
        raise ValidationError, numeric_invalid_message(numeric, require_positive, require_zero_plus)
      end
    end
  )
end

def integer_prompt(prompt, require_positive: false, require_zero_plus: false)
  numeric_prompt(prompt, ConvertString.to_integer,
                 require_positive: require_positive,
                 require_zero_plus: require_zero_plus)
end

def bigdecimal_prompt(prompt, require_positive: false, require_zero_plus: false)
  numeric_prompt(prompt, ConvertString.to_bigdecimal,
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
  prompt_until_valid(
    MESSAGES['loan_duration_prompt'],
    get_input: -> { gets.strip }, convert_input: lambda do |input|
      years, months = loan_duration_input_parse(input)
      (years * 12) + months
    end,
    validate: lambda do |months|
      raise StandardError if months.zero?
    end
  )
end
