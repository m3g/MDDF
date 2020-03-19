#
# x, y: Arrays of dimensions (nx,3), (ny,3)
# ifmol, ilmol: first and last indexes of array x to be considered (first and last atoms of molecule)
# jfmol, jlmol: first and last indexes of array y to be considered
# returns the the minimum distance between the points considered and
# the indexes of these points in x and y vectors
#
function minimumdistance(ifmol :: Int64, ilmol :: Int64, x :: Array{Float64},
                         jfmol :: Int64, jlmol :: Int64, y :: Array{Float64})
  local i, j
  dmin = +Inf
  for i in ifmol:ilmol
     for j in jfmol:jlmol
       d = dsquare(x,y,i,j)
       if d < dmin
         iatom = i
         jatom = j
         dmin = d
       end
     end
  end
  dmin = sqrt(dmin)
  return dmin, iatom, jatom
end




