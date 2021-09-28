# Launch School - RB101 Course - Lessons

## Dependencies

### ruby-common

Clone *ruby-common* to this project's parent directory: ```https://github.com/lightmotive/ruby-common.git```

- That project's files will eventually be converted into gems to obviate the need for "require_relative" and avoid "dependency hell".

## Helpful shell scripts
- Create Questions file with specified number of questions:
  ```bash
  touch 'questions.rb'
  printf "# frozen_string_literal: true\n" > "questions.rb"
  for i in {1..10}; do printf "\n# ***\nputs \"%s* Question $i *\"\n# ...\n" "\n" >> "questions.rb"; done
  ```
