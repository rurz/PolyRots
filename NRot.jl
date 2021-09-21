using PixelsGT

rd(Q₁, Q₂, q₁, q₂, n, m, θ, j) = real(conj(LKd(Q₁, Q₂, n, m, j)) * exp(-1im * θ * m) * LKd(q₁, q₂, n, m, j))

ru(Q₁, Q₂, q₁, q₂, n, m, θ, j) = real(conj(LKu(Q₁, Q₂, n, m, j)) * exp(-1im * θ * m) * LKu(q₁, q₂, n, m, j))

export RdM, RuM

function RdM(θ, j)
    m = zeros((Integer(2 * j + 1), Integer(2 * j + 1), Integer(2 * j + 1), Integer(2 * j + 1)))
    Threads.@threads  for Q₁ in 1:Integer(2*j+1)
        for Q₂ in 1:Integer(2*j+1)
            for q₁ in 1:Integer(2*j+1)
                for q₂ in 1:Integer(2*j+1)
                    m[Q₁, Q₂, q₁, q₂] = sum([rd(Q₁-j-1, Q₂-j-1, q₁-j-1, q₂-j-1, n, m, θ, j) for n in 0:Integer(2*j) for m in -Integer(n):2:Integer(n)])
                end
            end
        end
    end
    return m
end

function RuM(θ, j)
    m = zeros((Integer(2 * j + 1), Integer(2 * j + 1), Integer(2 * j + 1), Integer(2 * j + 1)))
    Threads.@threads  for Q₁ in 1:Integer(2*j+1)
        for Q₂ in 1:Integer(2*j+1)
            for q₁ in 1:Integer(2*j+1)
                for q₂ in 1:Integer(2*j+1)
                    m[Q₁, Q₂, q₁, q₂] = sum([ru(Q₁-j-1, Q₂-j-1, q₁-j-1, q₂-j-1, n, m, θ, j) for n in Integer(2*j + 1):Integer(4*j) for m in -Integer(4 * j - n):2:Integer(4 * j - n)])
                end
            end
        end
    end
    return m
end
