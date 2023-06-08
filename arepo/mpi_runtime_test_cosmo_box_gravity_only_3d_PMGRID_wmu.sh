mkdir -p ../out_file_logs/06082023_mpirun_2/

for p in 64 128 256
do
for t in {1..128}
do 
	echo -n "$p,$t,"
	# Do not count time for preparation
  bash test_cosmo_box_gravity_only_3d_prep.sh > ../out_file_logs/06062023_mpirun_1/$p_$t.out 2>&1 
  # Only count for MPI execution
	/usr/bin/time -q -f "%e,%P,%M" bash -c "bash test_cosmo_box_gravity_only_3d_PMGRID.sh $p $t > ../out_file_logs/06082023_mpirun_2/$p_$t.out 2>&1" 
done
done
