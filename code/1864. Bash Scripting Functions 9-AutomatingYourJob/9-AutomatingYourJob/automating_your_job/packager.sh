function makeDirectoryIfNecessary {
  if [[ -d $1 ]]
  then
    echo "Directory $1 exists"
  else
    mkdir $1
  fi
}

while getopts "d:" opt
do
  case "$opt" in 
    d) DIR=${OPTARG};;
  esac
done

if [[ ${DIR} == '' ]]
then
  echo "Please provide an image directory."
  exit 1;
fi

RESULTS_DIR="packaged_images"
mkdir $RESULTS_DIR

for IMAGE in $(ls $DIR)
do
  FIRST_LETTER=${IMAGE:0:1}
  TARGET_DIRECTORY="$RESULTS_DIR/$FIRST_LETTER"
  makeDirectoryIfNecessary $TARGET_DIRECTORY
  cp "$DIR/$IMAGE" "$TARGET_DIRECTORY/$IMAGE"
done

