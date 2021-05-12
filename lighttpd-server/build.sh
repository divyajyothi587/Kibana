#! /bin/bash
export IMG_TAG=${1}
#######################################
function lighttpd_Image() {
  if [[ ! -z ${IMG_TAG} ]] ; then
    echo "Building docker image with tag ${IMG_TAG}"
    docker build -t ${IMG_TAG} .
  else
    echo "Tag name need to pass along with this script as follow : ./build.sh akhilrajmailbox/elasticsearch:lighttpd"
    exit 1
  fi
}


lighttpd_Image
