for t in 1 2 4 8 16 32 64
do 
	echo -n "$t,"
	/usr/bin/time -f "%e" bash -c "bash test_cosmo_box_gravity_only_3d.sh $t > ../out_file_logs/05182023_mpirun_1_$t.out 2>&1"
done
