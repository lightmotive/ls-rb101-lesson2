# Launch School - RB101 Course - Lessons

## Helpful shell scripts
- Create Questions file with specified number of questions:
  
  ```ruby
  touch 'questions.rb'
  printf "# frozen_string_literal: true" > "questions.rb"
  for i in {1..10}; do printf "\n\n# ***\n# Question $i\nputs '* Question $i *'\n# " >> "questions.rb"; done
  ```
  