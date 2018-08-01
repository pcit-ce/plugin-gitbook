#!/bin/sh

START=`date "+%F %T"`

if [ $1 = "sh" ];then sh ; exit 0 ; fi
if [ $1 = "version" ];then exec gitbook --version ; fi

git config --global user.name ${GIT_USERNAME:-none}

git config --global user.email ${GIT_USEREMAIL:-none@none.com}

rm -rf node_modules _book

cp -a . ../gitbook

cd ../gitbook

main(){
  gitbook build
  cp -a _book ../gitbook-src
  case $1 in
    server )
      exec gitbook serve
      exit 0
      ;;
    deploy )
      cd _book
      git init
      git remote add origin ${GIT_REPO}
      git add .
      COMMIT=`date "+%F %T"`
      git commit -m "${COMMIT}"
      if [ -z ${BRANCH} ];then
        git push -f origin master
      else
        git push -f origin master:${BRANCH}
      fi
      ;;
    esac
    echo $START
    date "+%F %T"
}

main $@
