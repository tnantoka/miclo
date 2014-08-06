rails_best_practices -f html -o app .
open -a Firefox rails_best_practices_output.html

rubycritic app
open -a Firefox tmp/rubycritic/overview.html

