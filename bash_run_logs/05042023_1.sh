## Directory: arepo

# test.sh only runs on one core for 1d problems, we don't need many cpus for test
srun --partition=shared --pty --account=csd759 --nodes=1 --ntasks-per-node=1 --cpus-per-task=2 --mem=16G -t 04:00:00 --wait=0 --export=ALL /bin/bash

# export SYSTYPE="Ubuntu"

module purge
module load slurm cpu gcc openmpi gsl gmp fftw hdf5 hwloc py-pip

# Compile with 2 threads
make -j 2

pip install h5py matplotlib

bash test.sh | tee -a ../out_file_logs/05042023_1.out