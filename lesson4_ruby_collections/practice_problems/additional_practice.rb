# frozen_string_literal: true

flintstones = %w[Fred Barney Wilma Betty Pebbles BamBam]
# Turn this array into a hash where the names are the keys and the values are the positions in the array.

flintstones_hash = {}
flintstones.each_with_index { |name, idx| flintstones_hash[name] = idx }
p flintstones_hash
