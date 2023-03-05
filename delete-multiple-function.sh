#!/bin/bash
# Loop through the list of function names and delete each function
for FUNCTION_NAME in "$@"
do
  gcloud functions delete "${FUNCTION_NAME}" --quiet
done
