function update-master --description "update master branch"
  set __CUR_BRANCH (git rev-parse --abbrev-ref HEAD)
  if [ $__CUR_BRANCH = "master" ]
    git pull
    return
  end
 
  git checkout master
  git pull
  git checkout $__CUR_BRANCH
  set -e __CUR_BRANCH
end
