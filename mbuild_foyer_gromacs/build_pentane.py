import numpy as np

import mbuild as mb
from mbuild.examples.alkane.alkane import Alkane

# Class definitions for pentane
class Pentane(mb.Compound):
    """ mBuild class definitions for the construction of pentane.

    Wraps the mb.Alkane recipe for the generation of the compound.

    """
    def __init__(self):
        super(Pentane, self).__init__()
        # carbon chain with length 3, capped with 2 methyl groups
        self.add(Alkane(n=5, cap_front=True, cap_end=True))


# definition for the box filled with pentane
class Pentane_box(mb.Compound):
    """ mBuild class definitions for the construction of a box of pentane

    Wrapper for the mb.fill_box command, which leverages PACKMOL.

    """
 
    def __init__(self):
        super(Pentane_box, self).__init__()

        # fill box with pentanes
        box = mb.Box([3, 3, 3])
        pentane = Pentane()
        self.add(mb.fill_box(compound=pentane, n_compounds=75, box=box))


if __name__ == "__main__":
    print('Building Pentane box system with:')
    print('{} nm box,\t {} pentane molecules'.format([3,3,3], 75))

    box_pentane = Pentane_box()

    print('Box building complete!')

    print('Saving to GROMACS TOPOLOGY and GRO files')
    box_pentane.save(filename='pentane_system.gro', overwrite=True)
    box_pentane.save(filename='pentane_system.top', forcefield_name='oplsaa', overwrite=True)

