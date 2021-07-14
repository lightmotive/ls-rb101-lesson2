# frozen_string_literal: true

require 'bigdecimal'

# String conversion lambdas
module ConvertString
  def self.to_integer
    ->(string) { Integer(string) }
  end

  def self.to_bigdecimal
    ->(string) { BigDecimal(string) }
  end
end
