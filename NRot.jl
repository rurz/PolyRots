using PixelsGT

rd(Q₁, Q₂, q₁, q₂, n, m, θ, j) = real(conj(LKd(Q₁, Q₂, n, m, j)) * exp(-1im * θ * m) * LKd(q₁, q₂, n, m, j))

ru(Q₁, Q₂, q₁, q₂, n, m, θ, j) = real(conj(LKu(Q₁, Q₂, n, m, j)) * exp(-1im * θ * m) * LKu(q₁, q₂, n, m, j))

export RdM, RuM, R

function RdM(θ, j)
    m = zeros((2 * j + 1, 2 * j + 1, 2 * j + 1, 2 * j + 1))
    Threads.@threads for Q₁ in -j:j
        for Q₂ in -j:j
            for q₁ in -j:j
                for q₂ in -j:j
                    m[Q₁ + j + 1, Q₂ + j + 1, q₁ + j + 1, q₂ + j + 1] = sum([rd(Q₁, Q₂, q₁, q₂, n, m, θ, j) for n in 0:2*j for m in -n:2:n])
                end
            end
        end
    end
    return m
end

function RuM(θ, j)
    m = zeros((2 * j + 1, 2 * j + 1, 2 * j + 1, 2 * j + 1))
    Threads.@threads for Q₁ in -j:j
        for Q₂ in -j:j
            for q₁ in -j:j
                for q₂ in -j:j
                    m[Q₁ + j + 1, Q₂ + j + 1, q₁ + j + 1, q₂ + j + 1] = sum([ru(Q₁, Q₂, q₁, q₂, n, m, θ, j) for n in (2*j + 1):4*j for m in -(4 * j - n):2:(4 * j - n)])
                end
            end
        end
    end
    return m
end

function R(θ, j)
    m = zeros((2 * j + 1, 2 * j + 1, 2 * j + 1, 2 * j + 1))
    Threads.@threads for Q₁ in -j:j
        for Q₂ in -j:j
            for q₁ in -j:j
                for q₂ in -j:j
                    m[Q₁ + j + 1, Q₂ + j + 1, q₁ + j + 1, q₂ + j + 1] = sum([rd(Q₁, Q₂, q₁, q₂, n, m, θ, j) for n in 0:2*j for m in -n:2:n]) + sum([ru(Q₁, Q₂, q₁, q₂, n, m, θ, j) for n in (2*j + 1):4*j for m in -(4 * j - n):2:(4 * j - n)])
                end
            end
        end
    end
    return m
end
