#!/bin/bash
#set -o nounset
#set -o errexit

LOCAL_ROOT=`pwd`
REPORT_DIR=reports

# make dir if it doesn't exist
if [ ! -d "$LOCAL_ROOT/$REPORT_DIR" ]; then
  mkdir "$LOCAL_ROOT/$REPORT_DIR"
fi

START=$(date +"%s")
START_DIR=$REPORT_DIR/`date '+%Y-%m-%d_%H.%M.%S'`

# append a line return to make sure last line is processed
sed -i '' -e '$a\' $LOCAL_ROOT/urls.txt

mkdir $START_DIR
cd $START_DIR

while read line; do psi --format=json "$line"; done < $LOCAL_ROOT/urls.txt >> psi.json

cd $LOCAL_ROOT

mv $LOCAL_ROOT/urls.txt $START_DIR

END=$(date +"%s")
DIFF=$(($END-$START))

echo -e "Reports took $(($DIFF / 60))min $(($DIFF % 60))sec"