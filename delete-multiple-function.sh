#!/bin/bash
# Loop through the list of function names and delete each function
for FUNCTION_NAME in "$@"
do
  read temp <<< $(gcloud functions describe "${FUNCTION_NAME}" --region=asia-northeast1 | grep name)
  IFS='/' read -r -a array <<< $temp
  region=${array[3]}
  gcloud functions delete "${FUNCTION_NAME}" --quiet --region="${region}"
done
