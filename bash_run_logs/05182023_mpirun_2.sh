srun --partition=compute --pty --account=csd759 --nodes=1 --ntasks-per-node=1 --cpus-per-task=128 --mem=96G -t 12:00:00 --wait=0 --export=ALL /bin/bash

module purge
module load slurm cpu/0.15.4 gcc openmpi gsl gmp fftw hdf5 hwloc py-pip

make -j 16

pip install h5py matplotlib

bash mpi_runtime_test_cosmo_box_gravity_only_3d.sh > ../out_file_logs/05182023_mpirun_2_result.out 2>&1
