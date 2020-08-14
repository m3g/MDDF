#
# Function that generates a new random position for a molecule
#
# the new position is returned in x, a previously allocated array
#
# x_solvent_random might be a view of the array that contains all the solvent
# molecules
#

function random_move!(x_ref :: AbstractArray{Float64}, 
                      irefatom :: Int64,
                      sides :: AbstractVector{Float64},
                      x_new :: AbstractArray{Float64}, aux :: MoveAux )

  # To avoid boundary problems, the center of coordinates are generated in a 
  # much larger region, and wrapped aftwerwards
  scale = 100.

  # Generate random coordiantes for the center of mass
  @. aux.newcm = -scale*sides/2 + random(Float64)*scale*sides

  # Generate random rotation angles 
  @. aux.angles = (2*pi)*random(Float64)

  # Copy the coordinates of the molecule chosen to the random-coordinates vector
  for i in 1:size(x_new,2)
    x_new[1,i] = x_ref[1,i]
    x_new[2,i] = x_ref[2,i]
    x_new[3,i] = x_ref[3,i]
  end
  
  # Take care that this molecule is not split by periodic boundary conditions, by
  # wrapping its coordinates around its reference atom
  wrap!(x_new,sides,@view(x_ref[1:3,irefatom]))

  # Move molecule to new position
  move!(x_new,aux)

  return nothing
end

