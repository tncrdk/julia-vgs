using BenchmarkTools

function main()
    function Formatting(link::String)
        return open(link) do io
            readline(io)
            txt = split(readline(io), ",")
            busses = [(parse(Int64, value), index) for (index, value) in enumerate(txt) if value != "x"]
            return busses
        end
    end
#= 1068781 =#
    function Recursive(base::Int64, index::Int64, busses)::Bool
        if index > length(busses)
            return true
        end
        if (base + busses[index][2] - 1) % busses[index][1] != 0
            return false
        end
        return Recursive(base, index + 1, busses)
    end
        
    function Checking(busses)
        println(busses)
        jump = busses[1][1]
        base = busses[1][1] * 10000
        while true
            if Recursive(base, 2, busses)
                println(base)
                return base
            end
            base += jump
            if base > 10^15
                return "Nada"
            end
        end
    end


        
    Checking(Formatting("13-des\\input.txt"))
end

main()