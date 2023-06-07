#!/bin/bash            # this line only there to enable syntax highlighting in this file
## shell script for code testing

#################################
## perform predefined examples ##
#################################

## Number of cores to compile and run the problem on
## use NUMBER_OF_TASKS=1 for 1d test problems!
NUM_PMGRID=$1
NUMBER_OF_TASKS=$2
PLOT=False # create plots? True/False

## choose your examples
TESTS=""

TESTS+="cosmo_box_gravity_only_3d "

## loop over all tests
for TEST in $TESTS
do
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

  ## compile Arepo
  rm ${RUNDIR}/Config.sh
  cp ${RUNDIR}/Config_${NUM_PMGRID}.sh ${RUNDIR}/Config.sh
  make -j ${NUMBER_OF_TASKS} CONFIG=${RUNDIR}/Config.sh BUILD_DIR=${RUNDIR}/build EXEC=${RUNDIR}/Arepo
  ((return_value=$?))    ## get return value
  if [ $return_value != 0 ]    ## check return value
  then echo "ERROR: test.sh:\t" $DIR "\t make failed!"
  exit $return_value
  fi
  
  ## change to RUNDIR in subshell and execute test simulation
  (cd ${RUNDIR} && mpiexec -np ${NUMBER_OF_TASKS} --oversubscribe ./Arepo ./param.txt)
  ((return_value=$?))    ## get return value
  if [ $return_value != 0 ]    ## check return value
  then echo "ERROR: test.sh:\t" $DIR "\t execution failed!"
  exit $return_value
  fi
  
  ## check result in example directory, this also creates some check plots
  python ${RUNDIR}/check.py ${RUNDIR} ${PLOT}
  ((return_value=$?))    ## get return value
  if [ $return_value != 0 ]    ## check return value
  then echo "ERROR: test.sh: test failed!"
  exit $return_value
  else echo "test.sh:\t" $DIR "\t test passed!"
  echo "cleaning up..."
  fi
  
  ## clean up
  rm -rf ./run
done

echo "tests"
echo ${TESTS}
echo "passed!"

exit ${return_value}
