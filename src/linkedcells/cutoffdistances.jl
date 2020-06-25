#
# cutoffdistances: This routine that returns a list of the distances 
#                  between atoms that are smaller than a specified cutoff,
#                  for a given set of coordinates.
#
# L. Martinez, Sep 23, 2014. (to Julia on June, 2020)
#

function cutoffdistances!(x_solute :: Array{Float64},
                          x_solvent :: Array{Float64},
                          lc_solute :: LinkedCells,
                          lc_solvent :: LinkedCells,
                          box :: Box,
                          d_in_cutoff :: CutoffDistances)

  # Maximum number of distances as set on input (might be resized here)
  maxdim = length(d_in_cutoff.d)

  # Loop over the boxes that contain solute atoms
  icell = 1
  while lc_solute.cell[icell] > 0
  
    # Check if this cell has a solvent atom, if not, cycle
    jcell = findfirst(jcell -> jcell == lc_solute.cell[icell], lc_solvent.cell)
    if jcell == nothing
      cycle
    end

    # 3D indexes of the current cell
    i, j, k = ijkcell(box,icell) 
    
    # Now, loop over the atoms of these cells, computing the distances      
    iat = lc_solute.firstatom(icell)
    while iat > 0

      # Coordinates of this solute atom
      xat = @view(x_solute[iat,1:3])

      # Inside box

      smalldcell!(data,ii,igroup1,i,j,k,memerror)
  
      # Interactions of boxes that share faces
  
      smalldcell!(data,ii,igroup1,i+1,j,k,memerror) 
      smalldcell!(data,ii,igroup1,i,j+1,k,memerror) 
      smalldcell!(data,ii,igroup1,i,j,k+1,memerror) 
  
      smalldcell!(data,ii,igroup1,i-1,j,k,memerror) 
      smalldcell!(data,ii,igroup1,i,j-1,k,memerror) 
      smalldcell!(data,ii,igroup1,i,j,k-1,memerror) 
  
      # Interactions of boxes that share axes
                   
      smalldcell!(data,ii,igroup1,i+1,j+1,k,memerror) 
      smalldcell!(data,ii,igroup1,i+1,j,k+1,memerror) 
      smalldcell!(data,ii,igroup1,i+1,j-1,k,memerror) 
      smalldcell!(data,ii,igroup1,i+1,j,k-1,memerror) 
  
      smalldcell!(data,ii,igroup1,i,j+1,k+1,memerror) 
      smalldcell!(data,ii,igroup1,i,j+1,k-1,memerror) 
      smalldcell!(data,ii,igroup1,i,j-1,k+1,memerror) 
      smalldcell!(data,ii,igroup1,i,j-1,k-1,memerror) 
  
      smalldcell!(data,ii,igroup1,i-1,j+1,k,memerror) 
      smalldcell!(data,ii,igroup1,i-1,j,k+1,memerror) 
      smalldcell!(data,ii,igroup1,i-1,j-1,k,memerror) 
      smalldcell!(data,ii,igroup1,i-1,j,k-1,memerror) 
  
      # Interactions of boxes that share vertices
  
      smalldcell!(data,ii,igroup1,i+1,j+1,k+1,memerror) 
      smalldcell!(data,ii,igroup1,i+1,j+1,k-1,memerror) 
      smalldcell!(data,ii,igroup1,i+1,j-1,k+1,memerror) 
      smalldcell!(data,ii,igroup1,i+1,j-1,k-1,memerror) 
  
      smalldcell!(data,ii,igroup1,i-1,j+1,k+1,memerror) 
      smalldcell!(data,ii,igroup1,i-1,j+1,k-1,memerror) 
      smalldcell!(data,ii,igroup1,i-1,j-1,k+1,memerror) 
      smalldcell!(data,ii,igroup1,i-1,j-1,k-1,memerror)   

      iat = lc_solute.nextatom(iat)
    end


    # First atom of the solute in that cell
    iat_first = lc_solute.firstatom(icell) 

  end

end

