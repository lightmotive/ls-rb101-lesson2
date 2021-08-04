# PROBLEM:

# Given a string, write a method `palindrome_substrings` which returns
# all the substrings from a given string which are palindromes. Consider
# palindrome words case sensitive.

# Test cases:

# palindrome_substrings("supercalifragilisticexpialidocious") == ["ili"]
# palindrome_substrings("abcddcbA") == ["bcddcb", "cddc", "dd"]
# palindrome_substrings("palindrome") == []
# palindrome_substrings("") == []

# ***

# Input: string
# Output: array of sub-strings that are palindromes
# Rules:
#   - Palindromes are words that case-sensitively read the same forward and backward.
#   - If there are no palindromes or the string is empty, return an empty array.
#   Questions:
#     - Do the sub-strings need to be sorted in any way? Maybe...would need to ask problem author/interviewer
#     - Will the input contain multiple words? No
# Mental model: Given a single-word string, return an array of all sub-strings that are case-sensitive palindromes.

# * Data structure *
# Create an array of all possible substrings from which the program can select palindrome sub-strings into a sub-array.

# * Algorithm *
# Key methods:
#   - substrings (extract all substrings from the string)
#   - is_palindrome? (check whether the string is a palindrome)
#   - palindrome_substrings (convert string to substrings array; select and return palindrome substrings as array).
#
# Pseudocode:
#
# Method: substrings(string)
# ==========================
# SET substring_length = 2
# SET string_length = (string length)
# SET result = []
#
# REPEAT
#   SET start_index = 0
#
#   WHILE (start_index + substring_length) <= string_length
#     SET substring = string from start_index through substring_length
#     APPEND substring to result
#     INCREMENT start_index
#   ENDWHILE
#
#   INCREMENT substring_length
# UNTIL substring_length > string_length
#
# RETURN result
#
# Method: is_palindrome?(string)
# ==============================
# RETURN string == (string reversed, case-sensitive comparison)
#
# Method: palindrome_substrings(string)
# =====================================
# SET substrings = substrings(string)
# SET result = new array
#
# FOR each string in substring
#   IF is_palindrome?(string)
#     APPEND string to result array
#   ENDIF
# ENDFOR
#
# RETURN result

def substrings_of_length(string, length)
  result = []
  start_index = 0
  string_length = string.length
  while start_index + length <= string_length
    result << string.slice(start_index, length)
    start_index += 1
  end
  result
end

def substrings(string)
  substring_length = 2
  string_length = string.length
  result = []

  until substring_length > string_length
    result.concat(substrings_of_length(string, substring_length))
    substring_length += 1
  end

  result
end

def is_palindrome?(string)
  string == string.reverse
end

def palindrome_substrings(string)
  substrings = substrings(string)
  result = []

  substrings.each do |substring|
    result << substring if is_palindrome?(substring)
  end

  result
end

p palindrome_substrings('supercalifragilisticexpialidocious') == ['ili']
p palindrome_substrings('abcddcbA') == %w[dd cddc bcddcb] # The order is different, but the elements are identical
p palindrome_substrings('palindrome') == []
p palindrome_substrings('') == []
