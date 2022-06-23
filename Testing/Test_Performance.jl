using BenchmarkTools

function fmap(list::Array{Float64})
    map(x -> x^2, list)
end

function fcom(list::Array{Float64})
    [x^2 for x = list]
end

function fdot(list::Array{Float64})
    list.^2
end

function floop(list::Array{Float64})
    result = similar(list)
    for i in eachindex(list)
        result[i] = list[i]^2
    end
    result
end

function foo()
    return nothing
end

list = randn(10000)

function test(list)

    @btime fmap($list)
    @btime fcom($list)
    @btime fdot($list)
    @btime floop($list)
    @btime foo()
    
    nothing
end

test(list)
#= @benchmark floop(list) =#