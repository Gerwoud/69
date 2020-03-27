#!/bin/bash

#$ -e /home/dietger/work
#$ -o /home/dietger/work
#$ -N water
#$ -p 0
#$ -m be
# 
#$ -S /bin/bash

 
#set -xv
export g09root=/opt/programs/g09-d.01
source $g09root/bsd/g09.profile
mkdir -p /scratch/dietger/water
export GAUSS_SCRDIR=/scratch/dietger/water

$g09root/g09 /home/dietger/work/water.com /scratch/dietger/water/water.out

# don't delete the result file if not able to copy to fileserver 
cp /scratch/dietger/water/water.out /home/dietger/work/water.out 
status=$?
if [ $status -eq 0 ] 
then 
   rm -rf /scratch/dietger/water
else
   host=`/bin/hostname`
   /usr/bin/Mail -v -s "Error at end of batch job" $USER <<EOF

At the end of the batch job the system could not copy the output file
	$host:/scratch/dietger/water/water.out
to
	/home/dietger/work/water.out
Please copy this file by hand or inform the system manager.

EOF
 
fi
