####################################################################################################
# ENVIRONMENT SETUP

using Pkg
Pkg.activate(".")

include("NRot.jl")
using DelimitedFiles

####################################################################################################
# PARAMETERS

const j = 3
const ang = pi/4

@info "The 'spin' parameter of the field is j = $j"
@info "The rotation angle is θ = $ang"

####################################################################################################
# LOWER AND UPPER MODE MATRICES

@info "Creating tetradimensional lower-modes matrix"
mdown = RdM(ang, j)

@info "Creating tetradimensional upper-modes matrix"
mup = RuM(ang, j)

####################################################################################################
# LOWER AND UPPER MODE MATRICES

@info "Writting tetradimensional matrices"
writedlm(joinpath(abspath(""), "data/data_tetra/tetrad_3"), mdown)
writedlm(joinpath(abspath(""), "data/data_tetra/tetrau_3"), mup)
