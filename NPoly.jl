using Pkg
Pkg.activate(".")

using PyPlot
using DelimitedFiles

include("NRot.jl")

pathfile = joinpath(abspath(""), "data/img_origin/diag7.png")
img = imgload(pathfile)

img_r = chsplit(img, 1)
img_g = chsplit(img, 2)
img_b = chsplit(img, 3)

const j = Integer((size(img_r)[1] - 1)/2)
const ang = pi/4

mrd = zeros((2 * j + 1, 2 * j + 1))
mgd = zeros((2 * j + 1, 2 * j + 1))
mbd = zeros((2 * j + 1, 2 * j + 1))

mru = zeros((2 * j + 1, 2 * j + 1))
mgu = zeros((2 * j + 1, 2 * j + 1))
mbu = zeros((2 * j + 1, 2 * j + 1))

mdown = RdM(ang, j)
mup = RuM(ang, j)

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

repd = PixelsGT.imgrep(mrd + mru, mgd + mgu, mbd + mbu)

begin
    imshow(repd)
    box(false)
    axis("off")
    savefig(joinpath(abspath(""), "data/img_target/Ndiag7_img_rot.png"))
end
