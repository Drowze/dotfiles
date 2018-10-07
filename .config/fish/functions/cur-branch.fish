function cur-branch --description "Returns the name of the current git branch"
  git rev-parse --abbrev-ref HEAD
end 
