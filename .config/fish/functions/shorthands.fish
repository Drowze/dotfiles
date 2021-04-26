# function be --description 'bundle exec rspec ......'
#   bundle exec $argv
# end

function ssh --description 'sshing passing $TERM'
  env TERM=xterm-256color ssh $argv
end
