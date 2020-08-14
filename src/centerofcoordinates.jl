
# Computes the center of coordinates of a vector coor, and returns it in the vector
# cm, which must be provided previously allocated


# With explicit passing of indexes of a subarray

function centerofcoordinates!(cm :: Vector{Float64}, coor :: AbstractArray{Float64})
  @. cm = 0.
  n = size(coor,2)
  for i in 1:n
    cm[1] = cm[1] + coor[1,i]
    cm[2] = cm[2] + coor[2,i]
    cm[3] = cm[3] + coor[3,i]
  end
  @. cm = cm / n
  return nothing
end

# without previous allocation

function centerofcoordinates(coor :: AbstractArray{Float64} )
  cm = zeros(3)
  centerofcoordinates!(cm,coor)
  return cm
end

