function vmux --description 'Use tmux inside vagrant instance'
  vagrant ssh -- -t 'tmux attach $@'
end
