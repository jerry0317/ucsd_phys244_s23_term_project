RUNDIR="../out_file_logs/06082023_mpirun_3"
mkdir -p ${RUNDIR}

for p in 64 128 256 512
do
for t in 16 32 64
do
for m in 500 1000 1500 2000 2500 3000 3500 4000 4500 5000
	echo -n "$p,$t,$m,"
	# Do not count time for preparation
  bash test_cosmo_box_gravity_only_3d_prep.sh > ${RUNDIR}/$p_$t_$m.out 2>&1 
  # Only count for MPI execution
	/usr/bin/time -q -f "%e,%P,%M" bash -c "bash test_cosmo_box_gravity_only_3d_PMGRID_MemSize.sh $p $t $m > ${RUNDIR}/$p_$t_$m.out 2>&1" 
done
done
done
