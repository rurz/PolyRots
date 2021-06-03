using Pkg
Pkg.activate(".")

using PixelsGT
using PyPlot
using DelimitedFiles

@info "Retrieving the two-dimensional field"
pathfile = joinpath(abspath(""), "data/img_origin/diag7.png")
img = imgload(pathfile)

@info "Splitting the carriers"
img_r = chsplit(img, 1)
img_g = chsplit(img, 2)
img_b = chsplit(img, 3)

const j = Integer((size(img_r)[1] - 1)/2)
const ang = pi/4

@info "The 'spin' parameter of the field is j = $j"

mr = zeros((2 * j + 1, 2 * j + 1))
mg = zeros((2 * j + 1, 2 * j + 1))
mb = zeros((2 * j + 1, 2 * j + 1))

@info "Performing transformation in R"
Threads.@threads for x in -j:j
    for y in -j:j
        mr[x + j + 1, y + j + 1] = real(Fqθ(ang, x, y, j, img_r))
    end
end

@info "Performing transformation in G"
Threads.@threads for x in -j:j
    for y in -j:j
        mg[x + j + 1, y + j + 1] = real(Fqθ(ang, x, y, j, img_g))
    end
end

@info "Performing transformation in B"
Threads.@threads for x in -j:j
    for y in -j:j
        mb[x + j + 1, y + j + 1] = real(Fqθ(ang, x, y, j, img_b))
    end
end


simg = PixelsGT.imgrep(mr, mg, mb)

@info "Writting the results"
writedlm(joinpath(abspath(""), "data/data_target/diag7_array_r.dat"), mr)
writedlm(joinpath(abspath(""), "data/data_target/diag7_array_g.dat"), mg)
writedlm(joinpath(abspath(""), "data/data_target/diag7_array_b.dat"), mb)

@info "Showing the transformed two-dimensional field"
begin
    imshow(simg)
    box(false)
    axis("off")
    savefig(joinpath(abspath(""), "data/img_target/diag7_img_rot.png"))
end
