function fish_prompt
  test "$status" -eq 0 && set_color cyan || set_color brred

  # Optimized for performance
  printf '⋊> %s%s%s%s ' \
    (set_color yellow) \
    (prompt_pwd) \
    (set_color normal) \
    (fish_git_prompt ' on %s')
end
