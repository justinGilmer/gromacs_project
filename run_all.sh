#!/bin/bash

# master bash script to run the two simulations

#------------------------------------------------------------

# copy over the proper module env

# check if module dir exists
mkdir -p ~/.lmod.d
cp $PWD/gromacs_module_env ~/.lmod.d/gromacs_module_env
module restore gromacs_module_env

# anaconda
if [ -d ~/.conda/envs/chbe_gromacs35 ]; then
	echo "Environment already exists"
	echo "skipping..."
else
	conda config --add channels omnia
	conda config --add channels conda-forge
	conda config --add channels mosdef
	conda config --add channels bioconda
	conda create -y --name chbe_gromacs35 python=3.5 mdtraj mbuild foyer
fi

#------------------------------------------------------------

#------------------------------------------------------------
# run the water simulation
cd $PWD/gromacs_water
bash simulate_water.sh
cd ..
#------------------------------------------------------------

#------------------------------------------------------------
# run the pentane MoSDeF simulation
cd $PWD/mbuild_foyer_gromacs
bash simulate_pentane.sh
cd ..
#------------------------------------------------------------


#------------------------------------------------------------
# let user know it was submitted
cat <<END
Success! The water box simulation and pentane box simulation
were successfully submitted!

These jobs will take a some time to run, especially with everyone in
class submitting.

We will continue the presentation soon, and will check back on these
later! You can logout for now!
END
#------------------------------------------------------------
