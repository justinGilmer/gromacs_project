#!/bin/bash

# script to build a box of water molecules using the spc216 topology
# file from gromacs itself

# submit SLURM job for pentane simulation
sbatch water_gromacs_run.slurm
