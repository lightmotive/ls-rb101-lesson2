# frozen_string_literal: true

require 'yaml'

language = 'en-US'
MESSAGES = YAML.load_file("messages_#{language}.yml").freeze
