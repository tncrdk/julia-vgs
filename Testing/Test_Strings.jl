using BenchmarkTools

function wrapper()
    function Test()
        a = collect(Int64, 'a':'z')
        return sum(a)
    end

    function Alphabet_Func()
        Alphabet = Dict{Char,Int64}(i => j for (i, j) in zip(collect('a':'z'), 1:26))
        return Alphabet
    end


    @btime $Alphabet_Func()
end

wrapper()