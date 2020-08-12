#
# Protein - TMAO (compare new and old implementations)
#

include("../../src/MDDF.jl")
using PDBTools

dir="/home/leandro/Drive/Alunos/Ivan/PCCP_revision"

atoms = PDBTools.readPDB("$dir/6Mnative.pdb")

protein = PDBTools.select(atoms,"protein")
solute = MDDF.Selection(protein,nmols=1 )

water = PDBTools.select(atoms,"water")
solvent = MDDF.Selection(water,natomspermol=3)

options = MDDF.Options(n_random_samples=1,lastframe=100)

trajectory = MDDF.Trajectory("$dir/6Mnative.dcd",solute,solvent)

@time lcP = MDDF.mddf(trajectory,options)


