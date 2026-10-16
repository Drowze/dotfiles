function git_branch_name -d "Get current branch name"
  set -l is_repo
  test -d .git && set is_repo "yes"

  if test "$is_repo" != "yes"
    set -l info (command git rev-parse --git-dir --is-bare-repository 2>/dev/null)
    test $info[2] = false && set is_repo "yes"
  end

  if test "$is_repo" != "yes"
    echo "Not a git repository" >/dev/stderr
    return 1
  end

  command git symbolic-ref --short HEAD 2> /dev/null ||
    command git show-ref --head -s --abbrev | head -n1 2> /dev/null
end
