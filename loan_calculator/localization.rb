# frozen_string_literal: true

require 'yaml'

language = 'en-US'
MESSAGES = YAML.load_file("loan_calculator_messages_#{language}.yml")
