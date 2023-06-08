#!/bin/bash            # this line only there to enable syntax highlighting in this file
## shell script for code testing

#################################
## perform predefined examples ##
#################################

## Number of cores to compile and run the problem on
## use NUMBER_OF_TASKS=1 for 1d test problems!
NUM_PMGRID=$1
NUMBER_OF_TASKS=$2
MEMSIZE=$3
PLOT=False # create plots? True/False

TEST="cosmo_box_gravity_only_3d"

DIR="./examples/"${TEST}"/"
RUNDIR="./run/examples/"${TEST}"/"

## compile Arepo
rm ${RUNDIR}/Config.sh
cp ${RUNDIR}/Config_${NUM_PMGRID}.sh ${RUNDIR}/Config.sh
rm ${RUNDIR}/param.txt
cp ${RUNDIR}/param_${MEMSIZE}.txt ${RUNDIR}/param.txt
make -j ${NUMBER_OF_TASKS} CONFIG=${RUNDIR}/Config.sh BUILD_DIR=${RUNDIR}/build EXEC=${RUNDIR}/Arepo
((return_value=$?))    ## get return value
if [ $return_value != 0 ]    ## check return value
then echo "ERROR: test.sh:\t" $DIR "\t make failed!"
exit $return_value
fi
  
## change to RUNDIR in subshell and execute test simulation
(cd ${RUNDIR} &&  mpiexec -np ${NUMBER_OF_TASKS} --oversubscribe /cm/shared/apps/AMDuProf_3.4.475/bin/AMDuProfCLI collect --config tbp --mpi --output-dir amduprof_out_$(date +"%Y_%m_%dT%H%M%S%_z") ./Arepo ./param.txt)
((return_value=$?))    ## get return value
if [ $return_value != 0 ]    ## check return value
then echo "ERROR: test.sh:\t" $DIR "\t execution failed!"
exit $return_value
fi
  
exit ${return_value}
