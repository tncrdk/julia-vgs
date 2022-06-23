x = 4

function foo()
    x::Union{Int64,Vector} = 2
    function a()
        function b()
            y = 5
            x = [1, 2, 3, 4]
            println("x: $x")
            println("y: $y")
        end
        x = 3
        b()
    end

    a()
    println("x: $x")
    @isdefined(y)
end

#= foo() =#

function d()
    x = 2
    println(x)
end

function ahh(x::Vector{Int})
    for i in 1:length(x)
        x[i] += 1
    end
    return x
end

function ehh(x::Int)
    return x += 1
end

array = [1, 2, 3]
ahh(array)
println(array)
