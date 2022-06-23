using BenchmarkTools

function main()
    function Formatting(filepath::String)
        txt::Vector{Tuple{Char,Int64}} = []
        for line in eachline(filepath)
            push!(txt, (line[1], parse(Int64, line[2:end])))
        end
        return txt
    end

    function Modify!(a::T, b::S, Scalar::Int64) where {S <: Array} where {T <: Array}
        for (index, value) in enumerate(b)
            a[index] += value * Scalar
        end
    end

    function ChangeState!(DirectionCommand::Char, Scalar::Int64, CurrentState::Vector{Float64})
        CommandRegister = Dict{Char,Vector{Float64}}(
            'N' => [0, 1, 0],
            'S' => [0, -1, 0],
            'W' => [-1, 0, 0],
            'E' => [1, 0, 0],
            'F' => [cosd(CurrentState[3]), sind(CurrentState[3]), 0],
            'R' => [0, 0, -1],
            'L' => [0, 0, 1]
        )

        Modify!(CurrentState, CommandRegister[DirectionCommand], Scalar)
    end

    function Simulating(Commands::Vector{Tuple{Char,Int64}})
        CurrentState = Float64[0, 0, 0]
        for (command, scalar) in Commands
            ChangeState!(command, scalar, CurrentState)
        end
        return CurrentState
    end

    ManhattanDistance(CurrentState::Vector{Float64}) = abs(CurrentState[1]) + abs(CurrentState[2])

    CommandsList = Formatting("12. des\\input.txt")
    @time CurrentState = Simulating(CommandsList)
    ManhattanDistance(CurrentState)
end

main()