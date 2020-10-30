# Working with multiple trajectories

Very commonly, one has multiple trajectories of the same system, and we
want to obtain the average results of all trajectories. We provide a
simple scheme to average the results of multiple MDDF calculations:

### Create a vector of result data structures, without initialization

Let us assume that we have three Gromacs trajectories, with file names
`traj1.xtc`, `traj2.xtc`, `traj3.xtc`. First let us create a list with
these file names:

```julia
trajs = [ "traj1.xtc" , "traj2.xtc" , "traj3.xtc" ]
```

And define a vector of `ComplexMixtures.Result` types with 3 positions, with undefined
initialization:

```julia
results = Vector{ComplexMixtures.Result}(undef,3)
```

### Run the calculations in a loop

The calculation on the multiple trajectories is then performed in a
simple loop, such as

```julia
atoms = PDBTools.readPDB("./system.pdb")
solute = ComplexMixtures.Selection(atoms,"protein",nmols=1)
solvent = ComplexMixtures.Selection(atoms,"resname TMAO",,natomspermol=14)
for i in 1:3 # alternatively use 1:length(trajs) 
  trajectory = ComplexMixtures.Trajectory(trajs[i],solute,solvent)
  results[i] = ComplexMixtures.mddf(trajectory)
end
```

### Merge the results of several trajectories, with proper weights

Of course, the resulting `results` vector will contain at each position
the results of each calculation. To merge these results in a single
result data structure, use:

```julia
R = ComplexMixtures.merge(results)
```

The `R` structure generated contains the averaged results of all
calculations, with weights proportional to the number of frames of each
trajectory. That is, if the first trajectory had 2000 frames, and the
second and third trajectories have 1000 frames each, the first
trajectory will have a weight of 0.5 on the final results. The `merge` function
can be used to merge previously merged results with new results as well.

!!! tip

    The names of the files and
    and weights are stored in the `R.files` and `R.weights` vectors of
    the results structure:
    ```julia
    julia> R.files
    3-element Array{String,1}:
     "./traj1.xtc"
     "./traj2.xtc"
     "./traj3.xtc"
    
    julia> R.weights
    2-element Array{Float64,1}:
     0.5
     0.25
     0.25
    
    ```
    It is not a bad idea to check if that is what you were expecting.


