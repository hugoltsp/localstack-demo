#!/bin/bash

if [ $# -eq 0 ]
  then
    cmd='help'
  else
    # shellcheck disable=SC2124
    cmd=$@
fi

# shellcheck disable=SC2086
docker run -e AWS_ACCESS_KEY_ID='hugoltsp' \
 -e AWS_SECRET_ACCESS_KEY='hugoltsp' \
 -e AWS_DEFAULT_OUTPUT='json' \
 -e AWS_DEFAULT_REGION='sa-east-1' \
 --network localstackdemo_local \
 --rm -it amazon/aws-cli:2.2.5 \
 --endpoint-url=http://localstack:4566 $cmd