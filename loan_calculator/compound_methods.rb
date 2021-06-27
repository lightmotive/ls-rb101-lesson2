# frozen_string_literal: true

require_relative 'localization'
require_relative 'prompt'

COMPOUND_METHODS =
  {
    monthly: {
      option_display: MESSAGES['compound_method_monthly_display'],
      duration_prompt: -> { prompt_loan_duration },
      interest_rate_prompt: lambda do
        rate = prompt_float(MESSAGES['compound_method_monthly_prompt_interest_rate'],
                            require_zero_plus: true) / 100
        puts format(MESSAGES['interest_rate_APR_confirmation'], APR: rate * 100)
        rate
      end,
      payment: lambda do |principal, interest_rate, duration|
        return principal / duration if interest_rate.zero?

        monthly_interest_rate = interest_rate / 12
        principal * (monthly_interest_rate / (1 - (1 + monthly_interest_rate)**-duration))
      end,
      show_result: lambda do |principal, duration, payment|
        puts format(MESSAGES['monthly_payments_display'], payment_count: duration, payment: payment)
        total_interest = (payment * duration) - principal
        puts format(MESSAGES['total_interest_display'], interest: total_interest)
      end
    }
  }.freeze
