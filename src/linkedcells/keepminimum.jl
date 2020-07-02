#
# Function that returns the structure containing the list of the distances found keeping
# only the minimum distance between pairs of molecules, the remaining of the vectors
# will be zeroed
#

# This function will return the d_in_cutoff data modified such that only the pair of atoms
# corresponding to the minimum distance between each pair of molecules is retained in the 
# arrays. All other elements will be zeroed.   

function keepminimum!(nd :: Int64, d :: Vector{Float64}, iat :: Vector{Int64}, jat :: Vector{Int64},
                      imol :: Vector{Int64}, jmol :: Vector{Int64},
                      imol_ref :: Vector{Int64}, jmol_ref :: Vector{Int64})

  # Check to which molecule each atom of the list belongs
  for i in 1:nd
    imol[i] = imol_ref[iat[i]]
    jmol[i] = jmol_ref[jat[i]]
  end

  for i in 1:nd-1
    # If this position is already a repeated one, lets not waste time
    if iat[i] == 0
      continue
    end
    for j in i+1:nd
      # If this position is already a repeated one, lets not waste time
      if iat[j] == 0
        continue  
      end
      # If the molecules involved are the same, keep the smallest distance
      # in the smaller index, and eliminates the other
      if imol[j] == imol[i] && jmol[j] == jmol[i] 
        if d[j] < d[i]
          iat[i] = iat[j]
          jat[i] = jat[j]
          d[i] = d[j]
        end
        iat[j] = 0
        jat[j] = 0
        imol[j] = 0
        jmol[j] = 0
        d[j] = 0.
      end
    end
  end

  # Put the zeros at the end
  nonzero = 0
  for i in 1:nd
    if imol[i] > 0 
      nonzero = nonzero + 1
      if nonzero < i
        d[nonzero] = d[i]
        iat[nonzero] = iat[i]
        jat[nonzero] = jat[i]
        imol[nonzero] = imol[i]
        jmol[nonzero] = jmol[i]
        d[i] = 0.
        iat[i] = 0
        jat[i] = 0
        imol[i] = 0
        jmol[i] = 0
      end
    end
  end

end


# Calling the function using the structures instead of the vectors

keepminimum!(d_in_cutoff :: CutoffDistances,
             solute :: SoluteOrSolvent,
             solvent :: SoluteOrSolvent ) = 
  keepminimum!(d_in_cutoff.nd[1],d_in_cutoff.d,d_in_cutoff.iat,d_in_cutoff.jat,
               d_in_cutoff.imol, d_in_cutoff.jmol,
               solute.imol, solvent.imol)

