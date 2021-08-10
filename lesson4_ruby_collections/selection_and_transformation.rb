# frozen_string_literal: true

produce = {
  'apple' => 'Fruit',
  'carrot' => 'Vegetable',
  'pear' => 'Fruit',
  'broccoli' => 'Vegetable'
}

# Exercise: Implement the select_fruit method

def select_fruit(produce)
  produce.select { |_, type| type == 'Fruit' }

  # Imperatively, one would use a while loop with an if statement to build a new hash.
  # Create a new hash object
  # Get all hash keys as array
  # Loop through each hash key
  # type = hash[key]
  # if type = "Fruit", add the key-value pair to the new hash object
  #   Consider using clone to ensure values in original hash are unmodified.
end

p select_fruit(produce) # => {"apple"=>"Fruit", "pear"=>"Fruit"}
