
#!/bin/bash

while getopts "a:b:c" opt
do
  case "$opt" in 
    a) echo "-a invoked with argument: ${OPTARG}";;
    b) echo "-b invoked with argument: ${OPTARG}";;
    c) echo '-c invoked';;
  esac
done

# Print all files
for f in $(ls)
do 
  echo $f
done

# Print all error files

for f in $(ls error*)
do 
  echo "File $f contains logged errors"
done


function func {
  echo "Arg 1 is $1"
  echo "Arg 2 is $2"
}

#func "hi there" "bob"
func hi bob
