#!/bin/bash
# Loop through the list of function names and delete each function
for FUNCTION_NAME in "$@"
do
  # echo "gcloud functions list  --filter=\"NAME~${FUNCTION_NAME}\"  --format=\"value(REGION)\""
  # region=$(gcloud functions list  --filter="NAME~$FUNCTION_NAME"  --format="value(REGION)")
  region=$(gcloud functions list | grep -E '(^|\s)python-http-function($|\s)' | awk '{print $5}')
  # Check if region is empty
  if [[ -z $region ]]
  then
    echo "Failed to retrieve region for function ${FUNCTION_NAME}"
  else
    echo "Deleting "
    gcloud functions delete "${FUNCTION_NAME}" --quiet --region="${region}"
  fi
done
