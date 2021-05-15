using PixelsGT
using PyPlot
using DelimitedFiles

@info "Retrieving the two-dimensional field"
img = imgload("m13.png")

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
for x in -j:j
   for y in -j:j
       mr[x + j + 1, y + j + 1] = real(Fqθ(ang, x, y, j, img_r))
   end
end

@info "Performing transformation in G"
for x in -j:j
   for y in -j:j
       mg[x + j + 1, y + j + 1] = real(Fqθ(ang, x, y, j, img_g))
   end
end

@info "Performing transformation in B"
for x in -j:j
   for y in -j:j
       mb[x + j + 1, y + j + 1] = real(Fqθ(ang, x, y, j, img_b))
   end
end

simg = VisitingICF2021.imgrep(mr, mg, mb)

@info "Writting the results"
writedlm("imgr.dat", mr)
writedlm("imgg.dat", mg)
writedlm("imgb.dat", mb)

@info "Showing the transformed two-dimensional field"
begin
    imshow(simg)
    box(false)
    axis("off")
    savefig("imgrot.png")
end
