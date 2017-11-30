#!/bin/bash

# bash script to build and atomtype the system in mBuild, and feed
#       into GROMACS with SLURM command

# activate the anaconda environment
source activate chbe_gromacs35

# build mbuild system
python build_pentane.py

# ensure that the GROMACS files were generated
if [ -e pentane_system.gro && -e pentane_system.top ]; then
    echo "Found pentane files for GROMACS!"
else
    echo "No GROMACS files found for pentane system."
    echo "mBuild or Foyer did not seem to work correctly."
    exit 1
fi

# submit SLURM job for pentane simulation
sbatch mbuild_run_gromacs.slurm
