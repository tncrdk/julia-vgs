function SieveOld(MaxLimit)
    AllNum = fill(true, MaxLimit)
    primes = []

    p = 2

    while p <= MaxLimit
        if AllNum[p]
            push!(primes, p)
            for i in p^2:p:MaxLimit
                AllNum[i] = false
            end
        end
        if p == 2
            p += 1
        else
            p += 2
        end
    end
    return primes
end

function Sieve(MaxLimit)
    AllNum = fill(false, MaxLimit)
    AllNum[2] = true
    AllNum[3] = true
    primes = [2, 3]

    for i = 7:6:length(AllNum)
        AllNum[i] = true
        AllNum[i - 2] = true
    end

    p = 6
    while p + 1 <= MaxLimit
        if AllNum[p - 1]
            push!(primes, p - 1)
            for i in (p - 1)^2:(p - 1):MaxLimit
                AllNum[i] = false
            end
        end
        if AllNum[p + 1]
            push!(primes, p + 1)
            for i in (p + 1)^2:(p + 1):MaxLimit
                AllNum[i] = false
            end
        end
        p += 6
    end

    return primes
end

@time Sieve(1_000_000)