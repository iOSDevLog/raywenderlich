#!/bin/bash

# Dependencies
# Install chance.js (chance-cli):
# - npm install -g chance-cli
# 


id=1
echo "["
for id in `seq 1 30`;
do
  echo "
  {
    \"id\": ${id},
    \"name\": \"`chance name`\",
    \"mobile\": \"`chance phone`\",
    \"email\": \"`chance email`\",
    \"image\": \"\",
    \"department\": \"Engineering\",
    \"title\": \"`chance profession --rank true`\",
    \"bio\": \"`chance paragraph --sentences 4`\",
    \"twitter\": \"`chance twitter`\"
  },"
done    
echo "]"