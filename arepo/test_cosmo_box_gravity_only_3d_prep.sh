#!/bin/bash            # this line only there to enable syntax highlighting in this file
## shell script for code testing

#################################
## perform predefined examples ##
#################################

TEST="cosmo_box_gravity_only_3d"

DIR="./examples/"${TEST}"/"
RUNDIR="./run/examples/"${TEST}"/"

## clean up 
rm -rf ./run

## create run directory
mkdir -p ${RUNDIR}

## copy Config and parameter file to run directory
cp -r ${DIR}/* ${RUNDIR}

## create ICs in run directory
echo ${DIR}
python ${RUNDIR}/create.py ${RUNDIR}
((return_value=$?))    ## get return value
if [ $return_value != 0 ]    ## check return value
then echo "ERROR: test.sh:\t" $DIR "\t python create.py failed!"
exit $return_value
fi

exit $return_value