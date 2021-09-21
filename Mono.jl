####################################################################################################
# ENVIRONMENT SETUP

using Pkg
Pkg.activate(".")

using PyPlot
using DelimitedFiles

include("NRot.jl")

####################################################################################################
# PREAMBLE ADQUISITIONS

@info "Retrieving the two-dimensional field"
pathfile = joinpath(abspath(""), "data/img_origin/bwmono10x10.png")
img = imgload(pathfile)

####################################################################################################
# PARAMETERS

if isodd(size(img)[1]) == true
	const j = Integer((size(img)[1] - 1)/2)
elseif iseven(size(img)[1]) == true
	const j = (size(img)[1] - 1)/2
end
const ang = pi/4

@info "The 'spin' parameter of the field is j = $j"
@info "The rotation angle is $ang"

####################################################################################################
# TARGET MATRICES

imgrot = zeros((Integer(2 * j + 1), Integer(2 * j + 1)))

####################################################################################################
# LOWER AND UPPER MODE MATRIx

@info "Calculating lower modes matrix"
mdown = RdM(ang, j)

@info "Calculating upper modes matrix"
mup = RuM(ang, j)

mmodes = mdown + mup

####################################################################################################
# CALCULATIONS

@info "Performing rotation"
for x in 1:Integer(2*j+1)
    for y in 1:Integer(2*j+1)
        imgrot[x, y] = sum([mmodes[x,y,l,m] * img[l,m] for l in 1:Integer(2*j+1) for m in 1:Integer(2*j+1)])
    end
end

@info "Writting the results"
writedlm(joinpath(abspath(""), "data/data_target/bwmono10x10_r.dat"), imgrot)
