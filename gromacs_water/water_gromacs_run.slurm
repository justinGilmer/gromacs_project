#!/bin/bash
#SBATCH --nodes=1
#SBATCH --time=1:00:00                  # 1 hours
#SBATCH --mem=2G                        # 2 GB RAM 
#SBATCH --output=water_box_sim.log      # output file
#SBATCH --partition=pascal              # low-latency RoCE network and 4 Titan X
#SBATCH --account=chbe285_gpu           # substitute appropriate group here
#SBATCH --gres=gpu:1                    # single GPU job

# add all modules
module restore gromacs_module_env

# adding Justin's pre compiled gromacs to our path
export PATH=/home/gilmerjb/bin/bin:$PATH

# generate initial structure file using gmx solvate
# water box with 200 molecules, 2x2x2nm box, spc216 structure
gmx solvate -cs spc216.gro -box 2 2 2 -maxsol 200 -o water_box.gro

# generate topology file containing necessary atomtypes
gmx pdb2gmx -water spc -ff oplsaa -f water_box.gro -p water_box.top

# energy minimize and then run nve at 298K
gmx grompp -f em.mdp -c water_box.gro -p water_box.top -o em.tpr

# run energy minimization using info from em.tpr binary
gmx mdrun -v -deffnm em

# run nve on system
gmx grompp -f nve.mdp -c em.gro -p water_box.top -o nve.tpr
gmx mdrun -v -deffnm nve
