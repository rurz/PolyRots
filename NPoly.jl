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
pathfile = joinpath(abspath(""), "data/img_origin/rgbb_dots31.png")
img = imgload(pathfile)

@info "Splitting the carriers"
img_r = chsplit(img, 1)
img_g = chsplit(img, 2)
img_b = chsplit(img, 3)

####################################################################################################
# PARAMETERS

const j = Integer((size(img_r)[1] - 1)/2)
const ang = pi/4

@info "The 'spin' parameter of the field is j = $j"

####################################################################################################
# TARGET MATRICES

mrd = zeros((2 * j + 1, 2 * j + 1))
mgd = zeros((2 * j + 1, 2 * j + 1))
mbd = zeros((2 * j + 1, 2 * j + 1))

mru = zeros((2 * j + 1, 2 * j + 1))
mgu = zeros((2 * j + 1, 2 * j + 1))
mbu = zeros((2 * j + 1, 2 * j + 1))

####################################################################################################
# LOWER AND UPPER MODE MATRICES

@info "Calculating lower modes matrix"
mdown = RdM(ang, j)

@info "Calculating upper modes matrix"
mup = RuM(ang, j)

####################################################################################################
# CALCULATIONS

@info "Performing rotation in the lower modes"
for x in 1:(2*j+1)
    for y in 1:(2*j+1)
        mrd[x, y] = sum([mdown[x,y,l,m] * img_r[l,m] for l in 1:(2*j+1) for m in 1:(2*j+1)])
    end
end

for x in 1:(2*j+1)
    for y in 1:(2*j+1)
        mgd[x, y] = sum([mdown[x,y,l,m] * img_g[l,m] for l in 1:(2*j+1) for m in 1:(2*j+1)])
    end
end

for x in 1:(2*j+1)
    for y in 1:(2*j+1)
        mbd[x, y] = sum([mdown[x,y,l,m] * img_b[l,m] for l in 1:(2*j+1) for m in 1:(2*j+1)])
    end
end

@info "Performing rotation in the upper modes"
for x in 1:(2*j+1)
    for y in 1:(2*j+1)
        mru[x, y] = sum([mup[x,y,l,m] * img_r[l,m] for l in 1:(2*j+1) for m in 1:(2*j+1)])
    end
end

for x in 1:(2*j+1)
    for y in 1:(2*j+1)
        mgu[x, y] = sum([mup[x,y,l,m] * img_g[l,m] for l in 1:(2*j+1) for m in 1:(2*j+1)])
    end
end

for x in 1:(2*j+1)
    for y in 1:(2*j+1)
        mbu[x, y] = sum([mup[x,y,l,m] * img_b[l,m] for l in 1:(2*j+1) for m in 1:(2*j+1)])
    end
end

@info "Assembling the polychromatic representation"
repd = PixelsGT.imgrep(mrd + mru, mgd + mgu, mbd + mbu)

@info "Writting the results"
writedlm(joinpath(abspath(""), "data/data_target/rgbb_dots31_array_r.dat"), mr)
writedlm(joinpath(abspath(""), "data/data_target/rgbb_dots31_array_g.dat"), mg)
writedlm(joinpath(abspath(""), "data/data_target/rgbb_dots31_array_b.dat"), mb)

@info "Showing the transformed two-dimensional field"
begin
    imshow(repd)
    box(false)
    axis("off")
    savefig(joinpath(abspath(""), "data/img_target/rgbb_dots31_img_rot.png"))
end
