#!/bin/bash

#Description:
#   Used to compare codes in 2 directories

#Directory structure needed:
#   - diff_directory.sh
#   - dire1
#       |_ file1.sh
#       |_ file2.sh
#   - dire2
#       |_ file1.sh
#       |_ file2.sh

#Note:
#   The order of input dire1 and dire2 needs to be adjusted 
#   so that the code in dire1 is a subset of the code in dire2 (the latter may have slightly more code).

#RUN:
#   diff_directory.sh dire1/ dire2/

if [ $# -ne 2 ]
then
	echo "Error. 2 parameters needed"
	exit 8
fi

dire1=$1
dire2=$2


echo "## Now diff all file names bwtween dire1 and dire2"
echo "---------------------------------------------"
# Use find command to list filenames in both directories
files_dir1=$(find "$dire1" -type f -exec basename {} \; | sort)
files_dir2=$(find "$dire2" -type f -exec basename {} \; | sort)

# Use diff command to compare filenames
diff <(echo "$files_dir1") <(echo "$files_dir2")

if [[ $dire1 != *"/"* || $dire2 != *"/"* ]]
then
    echo "Error. dire inputed must end with '/'"
    exit 8
fi

echo " "
echo "## Now check whether every code in dire1 is the same as the code in dire2"
echo "---------------------------------------------"
cd $dire1
for f in *
do
    echo -e "## Now diff "$f"\t\t"$f
    diff ../${dire1}$f ../${dire2}$f
done