#!/bin/bash

# script to build a box of water molecules using the spc216 topology
# file from gromacs itself

# ensure the water file is present
if [ -e spc216.top ] then
    echo "Success! Water topology found!"
else
    echo "Could not find water topology file \'spc216.top\'"
    exit 1
fi

# submit SLURM job for pentane simulation
sbatch water_gromacs_run.slurm
