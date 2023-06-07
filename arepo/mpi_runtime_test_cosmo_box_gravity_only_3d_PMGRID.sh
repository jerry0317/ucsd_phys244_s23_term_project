mkdir -p ../out_file_logs/06062023_mpirun_1/

for p in 64 128 256 512 1024
do
for t in {1..128}
do 
	echo -n "$t,"
	/usr/bin/time -f "%e" bash -c "bash test_cosmo_box_gravity_only_3d_PMGRID.sh $p $t > ../out_file_logs/06062023_mpirun_1/$p_$t.out 2>&1"
done
done
