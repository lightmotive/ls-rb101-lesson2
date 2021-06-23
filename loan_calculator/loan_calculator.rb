# frozen_string_literal: true

# 1. Understand the Problem
# -------------------------
# -  Inputs: loan amount, APR, loan input
# -  Outputs: monthly interest rate, loan input in months, monthly payment

# **Problem Domain:**
# - How to convert APR to monthly interest rate: https://smallbusiness.chron.com/convert-annual-interest-rate-monthly-rate-1822.html
#   Basically, divide the APR by 12

# **Implicit Requirements:**
# None

# **Clarifying Questions:**
# 1. Will the user enter the loan input in years, or years and months?
#      The example provided has input entered as years and months, so we'll go with that.
# 2. What is the compound frequency?
#      One of the expected outputs is "monthly interest rate," so we'll go with monthly compounding
#      to keep it simple for now. Design to make it easy to add different compounding terms.

# **Mental Model:**
# - Ask the user to provide a loan amount, APR expressed as a percentage, and the loan input in years and months.
# - Determine the monthly interest rate and potentially other compounding terms (fixed 12 for now).
# - Determine loan input in months to calculate the monthly payment.
# - Show the user the loan input in months and their monthly payment.

# 2. Examples / Test Cases / Edge Cases
# -------------------------------------
# - Test 1
#   - Inputs: 25000, 6%, 5 years
#   - Outputs: .005, 60, 483.32
# - Test 2
#   - Inputs: 300000, 3%, 15 years
#   - Outputs: .0025, 180, 2071.74
# - Test 3
#   - Inputs: 5000, 0%, 0 years 6 months
#   - Outputs: 0, 6, 833.33

# 3. Data Structure
# -----------------
# Use a hash table for the compounding options, including calculations.
# Use a YAML configuration file for messages.

# 4. Algorithm
# ------------
# START
#
# PRINT a welcome prompt
#
# GET loan_amount as a float.
# GET APR expressed as a percentage (float), e.g., 6.25.
# GET loan_duration_years as an integer.
# GET loan_duration_months as an integer.
#
# CALCULATE monthly_interest_rate by dividing APR by the number of compounding terms per year.
#   Use a default 12 periods per year for now.
# CALCULATE loan_duration_months as (years * 12) + months.
# CALCULATE monthly_payment using the provided formula and a design that allows substituting other formulas (hash).
#
# SHOW loan_duration_months and monthly_payment
#
# END

# 5. Code
# -------

require 'yaml'

language = 'en-US'
MESSAGES = YAML.load_file("loan_calculator_messages_#{language}.yml")

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

def value_or_default(value, default)
  value.nil? ? default : value
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

# Learning experience: by not following the planned logic, I hack-n-slashed to a more elegant solution.
# That took more time than expected. Next time, I'll keep it simple until better functionality is needed.
# On the other hand, I learned more about working with lambdas and RegEx in Ruby while creating a more flexible program.
# Can't wait to learn OOP with Ruby! Might use strategy pattern here.
# Is this an example of functional programming?
compound_methods = {
  monthly: {
    option_display: MESSAGES['compound_method_monthly_display'],
    duration_prompt: -> { prompt_loan_duration_months },
    interest_rate_prompt: lambda do
      rate = prompt_float(MESSAGES['compound_method_monthly_prompt_interest_rate'], require_zero_plus: true) / 100
      puts "Got it, #{rate * 100}%"
      rate
    end,
    payment: lambda do |principal, interest_rate, duration|
      return principal / duration if interest_rate.zero?

      monthly_interest_rate = interest_rate / 12
      principal * (monthly_interest_rate / (1 - (1 + monthly_interest_rate)**-duration))
    end,
    show_result: lambda do |principal, duration, payment|
      puts "#{duration} monthly payments of $#{format('%.2f', payment)}"
      total_interest = (payment * duration) - principal
      puts "Total interest: $#{format('%.2f', total_interest)}"
    end
  }
}

puts MESSAGES['welcome_message']
print "\n"

loan_amount = prompt_float(MESSAGES['loan_amount_prompt'], require_positive: true)

# User would select compound method here
method = compound_methods[:monthly]

interest_rate = method[:interest_rate_prompt].call
duration = method[:duration_prompt].call
payment = method[:payment].call(loan_amount, interest_rate, duration)

print "\n"
puts '--Payments and Interest--'
method[:show_result].call(loan_amount, duration, payment)
