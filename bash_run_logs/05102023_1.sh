## Directory: arepo

srun --partition=shared --pty --account=csd759 --nodes=1 --ntasks-per-node=1 --cpus-per-task=16 --mem=64G -t 04:00:00 --wait=0 --export=ALL /bin/bash

module load slurm cpu/0.15.4 gcc openmpi gsl gmp fftw hdf5 hwloc py-pip