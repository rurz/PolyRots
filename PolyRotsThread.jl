#using Pkg
#Pkg.activate(".")

using PixelsGT

pathfile = joinpath(abspath(""), "data/img_origin/diag7.png")
img = imgload(pathfile)

img_r = chsplit(img, 1)
img_g = chsplit(img, 2)
img_b = chsplit(img, 3)

img_rF64 = convert(Array{Float64}, img_r)
img_gF64 = convert(Array{Float64}, img_g)
img_bF64 = convert(Array{Float64}, img_b)

const j = Integer((size(img_r)[1] - 1)/2)
const ang = pi/4

# Lower modes rotation

anmd(q₁, q₂, n, m, j, adata) = LKd(q₁, q₂, n, m, j) * adata[q₁ + j + 1, q₂ + j + 1]

function fnmd(n, m, j, imgdat)
    vnm = zeros(ComplexF64, (2 * j + 1, 2 * j + 1))
    Threads.@threads for q₁ in -j:j
        for q₂ in -j:j
            vnm[q₁ + j + 1, q₂ + j + 1] = anmd(q₁, q₂, n, m, j, imgdat)
        end
    end
    return sum(vnm)
end

fnmdθ(θ, n, m, j, imgdat) = exp(-1im * m * θ) * fnmd(n, m, j, imgdat)

Fqdθ(θ, q₁, q₂, j, imgdat) = sum([conj(LKd(q₁, q₂, n, m, j)) * fnmdθ(θ, n, m, j, imgdat) for n in 0:2*j for m in -n:2:n])

mrd = zeros((2 * j + 1, 2 * j + 1))
mgd = zeros((2 * j + 1, 2 * j + 1))
mbd = zeros((2 * j + 1, 2 * j + 1))

Threads.@threads for x in -j:j
    for y in -j:j
        mrd[x + j + 1, y + j + 1] = real(Fqdθ(ang, x, y, j, img_rF64))
    end
end

Threads.@threads for x in -j:j
    for y in -j:j
        mgd[x + j + 1, y + j + 1] = real(Fqdθ(ang, x, y, j, img_gF64))
    end
end

Threads.@threads for x in -j:j
    for y in -j:j
        mbd[x + j + 1, y + j + 1] = real(Fqdθ(ang, x, y, j, img_bF64))
    end
end

# Upper modes

anmu(q₁, q₂, n, m, j, adata) = LKu(q₁, q₂, n, m, j) * adata[q₁ + j + 1, q₂ + j + 1]

function fnmu(n, m, j, imgdat)
    vnm = zeros(ComplexF64, (2 * j + 1, 2 * j + 1))
    Threads.@threads for q₁ in -j:j
        for q₂ in -j:j
            vnm[q₁ + j + 1, q₂ + j + 1] = anmu(q₁, q₂, n, m, j, imgdat)
        end
    end
    return sum(vnm)
end

fnmuθ(θ, n, m, j, imgdat) = exp(-1im * m * θ) * fnmu(n, m, j, imgdat)

Fquθ(θ, q₁, q₂, j, imgdat) = sum([conj(LKu(q₁, q₂, n, m, j)) * fnmuθ(θ, n, m, j, imgdat) for n in (2*j + 1):4*j for m in -(4 * j - n):2:(4 * j - n)])

mru = zeros((2 * j + 1, 2 * j + 1))
mgu = zeros((2 * j + 1, 2 * j + 1))
mbu = zeros((2 * j + 1, 2 * j + 1))

Threads.@threads for x in -j:j
    for y in -j:j
        mru[x + j + 1, y + j + 1] = real(Fquθ(ang, x, y, j, img_rF64))
    end
end

Threads.@threads for x in -j:j
    for y in -j:j
        mgu[x + j + 1, y + j + 1] = real(Fquθ(ang, x, y, j, img_gF64))
    end
end

Threads.@threads for x in -j:j
    for y in -j:j
        mbu[x + j + 1, y + j + 1] = real(Fqdθ(ang, x, y, j, img_bF64))
    end
end

mr = mrd + mru
mg = mgd + mgu
mb = mbd + mbu

recos = PixelsGT.imgrep(mr, mg, mb)
