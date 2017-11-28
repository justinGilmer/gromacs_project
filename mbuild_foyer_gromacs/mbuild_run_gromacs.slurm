#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=4
#SBATCH --time=1:00:00                  # 1 hours
#SBATCH --mem=2G                        # 2 GB RAM 
#SBATCH --output=mbuild_pentane.log     # output file
#SBATCH --partition=pascal              # low-latency RoCE network and 4 Titan X GPUs per node
#SBATCH --account=chbe285_gpu             # substitute appropriate group here
#SBATCH --gres=gpu:1                    # single GPU job

# add all modules
module restore gromacs_test

# run necessary gromacs files

# apply gromacs preprocessor (grompp) to read in and verify the topology
#   and structure of the system
# energy minimization algorithm also in place to minimize system through
#   em.mdp
gmx grompp -f em.mdp -c pentane_system.gro -p pentane_system.top -o em.tpr

# run energy minimization using info from em.tpr binary
gmx mdrun -v -deffnm em

# equilibrate for 500ps under nvt at 250K
gmx grompp -f equil.mdp -c em.gro -p pentane_system.top -o equil.tpr
gmx mdrun -v -deffnm equil

#sample under npt for 1ns at 250K and 1atm
gmx grompp -f sample.mdp
