#
# Translates atoms of vectory in x array such that center is in the origin
#
function center_to_origin!(x :: AbstractArray{Float64}, center :: AbstractVector{Float64})
  for i in 1:size(x,2)
    for j in 1:3
      x[j,i] = x[j,i] - center[j]
    end
  end
  return nothing
end