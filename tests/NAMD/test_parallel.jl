#
# Self - Water
#

using MDDF
using PDBTools

atoms = PDBTools.readPDB("./structure.pdb")
water_atoms = PDBTools.select(atoms,"water")
water = MDDF.Selection( water_atoms, natomspermol=3)

# Input options for the calcualtion
options = MDDF.Options(binstep=0.2)

trajectory = MDDF.Trajectory("./trajectory.dcd",water)
@time R = MDDF.mddf_linkedcells_parallel(trajectory,options)

