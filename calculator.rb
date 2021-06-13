# ask the user for two numbers
# ask the user for the operation to perform on those numbers
# perform the operation on the two numbers
# output the result

# answer = Kernel.gets
# Kernel.puts(answer)

Kernel.puts('Welcome to Calculator!')

Kernel.print("What's the first number? ")
number1 = Kernel.gets.strip.to_f

Kernel.print("What's the second number? ")
number2 = Kernel.gets.strip.to_f

Kernel.print("What's the operation? 1) add 2) subtract 3) multiply 4) divide: ")
operator = Kernel.gets.strip

result = case operator
         when '1' then number1 + number2
         when '2' then number1 - number2
         when '3' then number1 * number2
         when '4' then number1 / number2
         end

Kernel.puts(result)
