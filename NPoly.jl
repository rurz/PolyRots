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
pathfile = joinpath(abspath(""), "data/img_origin/bw9x9.png")
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
@info "The rotation angle is $ang"

####################################################################################################
# TARGET MATRICES

mr_1 = zeros((2 * j + 1, 2 * j + 1))
mg_1 = zeros((2 * j + 1, 2 * j + 1))
mb_1 = zeros((2 * j + 1, 2 * j + 1))

mr_2 = zeros((2 * j + 1, 2 * j + 1))
mg_2 = zeros((2 * j + 1, 2 * j + 1))
mb_2 = zeros((2 * j + 1, 2 * j + 1))

mr_3 = zeros((2 * j + 1, 2 * j + 1))
mg_3 = zeros((2 * j + 1, 2 * j + 1))
mb_3 = zeros((2 * j + 1, 2 * j + 1))

####################################################################################################
# LOWER AND UPPER MODE MATRIx

@info "Calculating lower modes matrix"
mdown = RdM(ang, j)

@info "Calculating upper modes matrix"
mup = RuM(ang, j)

mmodes = mdown + mup

####################################################################################################
# CALCULATIONS

@info "Performing first rotation"
for x in 1:(2*j+1)
    for y in 1:(2*j+1)
        mr_1[x, y] = sum([mmodes[x,y,l,m] * img_r[l,m] for l in 1:(2*j+1) for m in 1:(2*j+1)])
    end
end

for x in 1:(2*j+1)
    for y in 1:(2*j+1)
        mg_1[x, y] = sum([mmodes[x,y,l,m] * img_g[l,m] for l in 1:(2*j+1) for m in 1:(2*j+1)])
    end
end

for x in 1:(2*j+1)
    for y in 1:(2*j+1)
        mb_1[x, y] = sum([mmodes[x,y,l,m] * img_b[l,m] for l in 1:(2*j+1) for m in 1:(2*j+1)])
    end
end

@info "Performing second rotation"
for x in 1:(2*j+1)
    for y in 1:(2*j+1)
        mr_2[x, y] = sum([mmodes[x,y,l,m] * mr_1[l,m] for l in 1:(2*j+1) for m in 1:(2*j+1)])
    end
end

for x in 1:(2*j+1)
    for y in 1:(2*j+1)
        mg_2[x, y] = sum([mmodes[x,y,l,m] * mg_1[l,m] for l in 1:(2*j+1) for m in 1:(2*j+1)])
    end
end

for x in 1:(2*j+1)
    for y in 1:(2*j+1)
        mb_2[x, y] = sum([mmodes[x,y,l,m] * mg_1[l,m] for l in 1:(2*j+1) for m in 1:(2*j+1)])
    end
end

@info "Performing third rotation"
for x in 1:(2*j+1)
    for y in 1:(2*j+1)
        mr_3[x, y] = sum([mmodes[x,y,l,m] * mr_2[l,m] for l in 1:(2*j+1) for m in 1:(2*j+1)])
    end
end

for x in 1:(2*j+1)
    for y in 1:(2*j+1)
        mg_3[x, y] = sum([mmodes[x,y,l,m] * mg_2[l,m] for l in 1:(2*j+1) for m in 1:(2*j+1)])
    end
end

for x in 1:(2*j+1)
    for y in 1:(2*j+1)
        mb_3[x, y] = sum([mmodes[x,y,l,m] * mg_2[l,m] for l in 1:(2*j+1) for m in 1:(2*j+1)])
    end
end

@info "Assembling the polychromatic representation"
repd_1 = PixelsGT.imgrep(mr_1, mg_1, mr_1)
repd_2 = PixelsGT.imgrep(mr_2, mg_2, mr_2)
repd_3 = PixelsGT.imgrep(mr_3, mg_3, mr_3)

@info "Writting the results"
writedlm(joinpath(abspath(""), "data/data_target/bw9x9_r1.dat"), mr_1)
writedlm(joinpath(abspath(""), "data/data_target/bw9x9_g1.dat"), mg_1)
writedlm(joinpath(abspath(""), "data/data_target/bw9x9_b1.dat"), mb_1)

writedlm(joinpath(abspath(""), "data/data_target/bw9x9_r2.dat"), mr_2)
writedlm(joinpath(abspath(""), "data/data_target/bw9x9_g2.dat"), mg_2)
writedlm(joinpath(abspath(""), "data/data_target/bw9x9_b2.dat"), mb_2)

writedlm(joinpath(abspath(""), "data/data_target/bw9x9_r3.dat"), mr_3)
writedlm(joinpath(abspath(""), "data/data_target/bw9x9_g3.dat"), mg_3)
writedlm(joinpath(abspath(""), "data/data_target/bw9x9_b3.dat"), mb_3)


@info "Showing the transformed two-dimensional field"
begin
    imshow(repd_1)
    box(false)
    axis("off")
    savefig(joinpath(abspath(""), "data/img_target/bw9x9_rot1.png"))
end
begin
    imshow(repd_2)
    box(false)
    axis("off")
    savefig(joinpath(abspath(""), "data/img_target/bw9x9_rot2.png"))
end
begin
    imshow(repd_3)
    box(false)
    axis("off")
    savefig(joinpath(abspath(""), "data/img_target/bw9x9_rot3.png"))
end
