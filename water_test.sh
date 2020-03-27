#!/bin/bash

#$ -e /home/dietger/work
#$ -o /home/dietger/work
#$ -N water_test
#$ -p 0
#$ -m be
# 
#$ -S /bin/bash

 
#set -xv
export g09root=/opt/programs/g09-d.01
source $g09root/bsd/g09.profile
mkdir -p /scratch/dietger/water_test
export GAUSS_SCRDIR=/scratch/dietger/water_test

$g09root/g09 /home/dietger/work/water_test.com /scratch/dietger/water_test/water_test.out

# don't delete the result file if not able to copy to fileserver 
cp /scratch/dietger/water_test/water_test.out /home/dietger/work/water_test.out 
status=$?
if [ $status -eq 0 ] 
then 
   rm -rf /scratch/dietger/water_test
else
   host=`/bin/hostname`
   /usr/bin/Mail -v -s "Error at end of batch job" $USER <<EOF

At the end of the batch job the system could not copy the output file
	$host:/scratch/dietger/water_test/water_test.out
to
	/home/dietger/work/water_test.out
Please copy this file by hand or inform the system manager.

EOF
 
fi
