#!/bin/bash
# Loop through the list of function names and delete each function
for FUNCTION_NAME in "$@"
do
  region=$(gcloud functions list | grep -E "(^|\s)${FUNCTION_NAME}($|\s)" | awk '{print $5}')
  # Check if region is empty
  if [[ -z $region ]]
  then
    echo "Failed to retrieve region for function ${FUNCTION_NAME}"
  else
    echo "Deleting function: ${FUNCTION_NAME} in region ${region}"
    gcloud functions delete "${FUNCTION_NAME}" --quiet --region="${region}"
  fi
done
