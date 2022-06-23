
function foo()
    i::Int64 = 1
    while i <= 10
        i += 1
    end
    println(i) # Lager allocations
    return i
end

@time foo()