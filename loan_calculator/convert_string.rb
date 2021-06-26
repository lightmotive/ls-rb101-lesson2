# frozen_string_literal: true

# String conversion lambdas
module ConvertString
  def self.to_integer
    ->(string) { Integer(string) }
  end

  def self.to_float
    ->(string) { Float(string) }
  end
end
