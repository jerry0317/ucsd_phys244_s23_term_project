## Directory: arepo

srun --partition=shared --pty --account=csd759 --nodes=1 --ntasks-per-node=2 --cpus-per-task=2 --mem=64G -t 04:00:00 --wait=0 --export=ALL /bin/bash

# export SYSTYPE="Ubuntu"

module purge
module load slurm cpu/0.15.4 gcc openmpi gsl gmp fftw hdf5 hwloc py-pip

make -j 16

pip install h5py matplotlib

bash test_cosmo_box_gravity_only_3d.sh | tee -a ../out_file_logs/05102023_1.out