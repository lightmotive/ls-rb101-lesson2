str = "joe's favorite color is blue"

# Convert each word to capital case
p str.split.map(&:capitalize).join(' ')
