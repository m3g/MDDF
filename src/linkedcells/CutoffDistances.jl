#
# Structure to contain a list of all the distances smaller than
# the cutoff
#
struct CutoffDistances

  # To store all distances smaller than the cutoff
  d :: Vector{Float64} # All distances smaller than the cutoff
  iat :: Vector{Float64} # atom of the solute
  jat :: Vector{Float64} # atom of the solvent

end

