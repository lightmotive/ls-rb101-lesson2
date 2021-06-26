# frozen_string_literal: true

# 5. Code
# -------

require_relative 'localization'
require_relative 'prompt'
require_relative 'compound_methods'

puts MESSAGES['welcome_message']
print "\n"

loop do
  loan_amount = prompt_float(MESSAGES['loan_amount_prompt'], require_positive: true)

  # User would select compound method here
  method = COMPOUND_METHODS[:monthly]

  interest_rate = method[:interest_rate_prompt].call
  duration = method[:duration_prompt].call
  payment = method[:payment].call(loan_amount, interest_rate, duration)

  print "\n"
  puts MESSAGES['result_header']
  method[:show_result].call(loan_amount, duration, payment)

  show_prompt(MESSAGES['continue_prompt'])
  break unless gets.strip.downcase.start_with?('y')
end
