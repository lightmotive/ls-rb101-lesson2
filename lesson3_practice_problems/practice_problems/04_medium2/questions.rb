# frozen_string_literal: true

# ***
puts "\n* Question 1 *"
# Predict how the values and object ids will change throughout the flow of the code below:

def fun_with_ids
  a_outer = 42
  b_outer = 'forty two'
  c_outer = [42]
  d_outer = c_outer[0]

  a_outer_id = a_outer.object_id
  b_outer_id = b_outer.object_id
  c_outer_id = c_outer.object_id
  d_outer_id = d_outer.object_id

  puts "a_outer is #{a_outer} with an id of: #{a_outer_id} before the block."
  puts "b_outer is #{b_outer} with an id of: #{b_outer_id} before the block."
  puts "c_outer is #{c_outer} with an id of: #{c_outer_id} before the block."
  puts "d_outer is #{d_outer} with an id of: #{d_outer_id} before the block."
  puts

  1.times do
    a_outer_inner_id = a_outer.object_id
    b_outer_inner_id = b_outer.object_id
    c_outer_inner_id = c_outer.object_id
    d_outer_inner_id = d_outer.object_id

    puts "a_outer id was #{a_outer_id} before the block and is: #{a_outer_inner_id} inside the block."
    puts "b_outer id was #{b_outer_id} before the block and is: #{b_outer_inner_id} inside the block."
    puts "c_outer id was #{c_outer_id} before the block and is: #{c_outer_inner_id} inside the block."
    puts "d_outer id was #{d_outer_id} before the block and is: #{d_outer_inner_id} inside the block."
    puts

    a_outer = 22
    b_outer = 'thirty three'
    c_outer = [44]
    # All of the assignments above will reassign the variables to different objects (will not mutate the original objects).
    # Therefore, the object IDs for those variables will change.
    d_outer = c_outer[0]
    # That will point d_outer to the same object stored in the c_outer array's first object (index 0).
    # d_outer.object_id will match c_outer[0].object_id, but will be different from c_outer.object_id.
    #   Array objects have an object ID, and each element in an array has a separate object ID.

    puts "a_outer inside after reassignment is #{a_outer} with an id of: #{a_outer_id} before and: #{a_outer.object_id} after."
    puts "b_outer inside after reassignment is #{b_outer} with an id of: #{b_outer_id} before and: #{b_outer.object_id} after."
    puts "c_outer inside after reassignment is #{c_outer} with an id of: #{c_outer_id} before and: #{c_outer.object_id} after."
    puts "d_outer inside after reassignment is #{d_outer} with an id of: #{d_outer_id} before and: #{d_outer.object_id} after."
    puts

    a_inner = a_outer
    b_inner = b_outer
    c_inner = c_outer
    # All three assignments above will result in inner variables that point to the same objects as the assigned outer variables.
    d_inner = c_inner[0]
    # d_inner will point to the same object stored in c_inner[0] (the element, which is the number 44).

    a_inner_id = a_inner.object_id
    b_inner_id = b_inner.object_id
    c_inner_id = c_inner.object_id
    d_inner_id = d_inner.object_id

    puts "a_inner is #{a_inner} with an id of: #{a_inner_id} inside the block (compared to #{a_outer.object_id} for outer)."
    puts "b_inner is #{b_inner} with an id of: #{b_inner_id} inside the block (compared to #{b_outer.object_id} for outer)."
    puts "c_inner is #{c_inner} with an id of: #{c_inner_id} inside the block (compared to #{c_outer.object_id} for outer)."
    puts "d_inner is #{d_inner} with an id of: #{d_inner_id} inside the block (compared to #{d_outer.object_id} for outer)."
    puts
  end

  puts "a_outer is #{a_outer} with an id of: #{a_outer_id} BEFORE and: #{a_outer.object_id} AFTER the block."
  puts "b_outer is #{b_outer} with an id of: #{b_outer_id} BEFORE and: #{b_outer.object_id} AFTER the block."
  puts "c_outer is #{c_outer} with an id of: #{c_outer_id} BEFORE and: #{c_outer.object_id} AFTER the block."
  puts "d_outer is #{d_outer} with an id of: #{d_outer_id} BEFORE and: #{d_outer.object_id} AFTER the block."
  puts

  begin
    puts "a_inner is #{a_inner} with an id of: #{a_inner_id} INSIDE and: #{a_inner.object_id} AFTER the block."
  rescue StandardError
    puts 'ugh ohhhhh'
  end
  begin
    puts "b_inner is #{b_inner} with an id of: #{b_inner_id} INSIDE and: #{b_inner.object_id} AFTER the block."
  rescue StandardError
    puts 'ugh ohhhhh'
  end
  begin
    puts "c_inner is #{c_inner} with an id of: #{c_inner_id} INSIDE and: #{c_inner.object_id} AFTER the block."
  rescue StandardError
    puts 'ugh ohhhhh'
  end
  begin
    puts "d_inner is #{d_inner} with an id of: #{d_inner_id} INSIDE and: #{d_inner.object_id} AFTER the block."
  rescue StandardError
    puts 'ugh ohhhhh'
  end
  # All of the *_inner references within the begin...rescue...end constructs above would raise NameError exceptions
  # because they're inaccessible outside the block passed to the times method.
end

fun_with_ids

# ***
puts "\n* Question 2 *"
# Let's look at object id's again from the perspective of a method call instead of a block.
# If we took the contents of the 1.times block from the previous practice problem and moved it to a method to which we
# pass all of our outer variables, how would the values and object ids change throughout the flow of the code?

# Because the method would contain only assignments (no indexed assignments, concatenations, or other mutating methods),
# the arguments passed to the method would remain unchanged outside the method. Everything else would be the same.

# ***
puts "\n* Question 3 *"
# Study the following code and state what will be displayed...and why:

def tricky_method(a_string_param, an_array_param)
  a_string_param += 'rutabaga' # This is basically an assignment operation, which won't mutate the passed argument.
  an_array_param << 'rutabaga' # This concatenation mutates the array, which mutates the passed argument (same object).
end

my_string = 'pumpkins'
my_array = ['pumpkins']
tricky_method(my_string, my_array)

puts "My string looks like this now: #{my_string}"  # ...now: pumpkins
puts "My array looks like this now: #{my_array}"    # ...now: ["pumpkins", "rutabaga"]

# ***
puts "\n* Question 4 *"
# Modify the code above to swap which argument is mutated:

def tricky_method_two(a_string_param, _an_array_param)
  a_string_param << 'rutabaga'
  an_array_param = %w[pumpkins rutabaga]
end

my_string = String.new('pumpkins')
my_array = ['pumpkins']
tricky_method_two(my_string, my_array)

puts "My string looks like this now: #{my_string}"  # ...now: pumpkinsrutabaga
puts "My array looks like this now: #{my_array}"    # ...now: ["pumpkins"]

# ***
puts "\n* Question 5 *"
# How can we change tricky_method above to make the result easier to predict and easier for the next
# programmer to maintain?

# First, methods should do only one thing, and the method name should indicate what it's doing.
# tricky_method is doing two unrelated things, so we'd want to create two separate methods
# using Ruby conventions, e.g.:

def append_rutabaga(to_object)
  "#{to_object}rutabaga"
end

def append_rutabaga!(to_object)
  to_object << 'rutabaga'
end

my_string = append_rutabaga(String.new('pumpkins'))
my_array = append_rutabaga!(['pumpkins'])

puts "My string looks like this now: #{my_string}"  # ...now: pumpkinsrutabaga
puts "My array looks like this now: #{my_array}"    # ...now: ["pumpkins", "rutabaga"]

# ***
puts "\n* Question 6 *"
# How could the following method be simplified without changing its return value?

# def color_valid(color)
#   if color == "blue" || color == "green"
#     true
#   else
#     false
#   end
# end

def color_valid(color)
  %w[blue green].include?(color)
end
