using BenchmarkTools

#= Custom types =#
abstract type AbstractMapObject end
abstract type AbstractShip <: AbstractMapObject end
abstract type AbstractWaypoint <: AbstractMapObject end

mutable struct Waypoint{T} <: AbstractWaypoint
    x::T
    y::T
end

mutable struct Ship{T <: Real} <: AbstractShip 
    x::T
    y::T
    orientation::Waypoint{T}

    Ship{T}(a, b, c) where {T <: Real} = new(a, b, c)
end

#= Constructors =#
Ship(a::T, b::T, c::Waypoint{T}) where {T <: Real} = Ship{T}(a, b, c::Waypoint{T})
Ship{T}(a, b, c, d) where {T <: Real} = Ship{T}(a, b, Waypoint{T}(c, d))
Ship(a::T, b::T, c::T, d::T) where {T <: Real} = Ship{T}(a, b, c, d)
Ship{T}() where {T <: Real} = Ship{T}(0, 0, 0, 0)
Ship() = Ship{Float64}()


function main()
    CommandRegister = Dict{Char,Vector{Float64}}(
            'N' => [0, 1],
            'S' => [0, -1],
            'W' => [-1, 0],
            'E' => [1, 0],
            'R' => [-1, 0],
            'L' => [1, 0]
        )

    function UpdatePosition!(Shipobject::T, Scalar::Int64) where {T <: AbstractShip}
        Shipobject.x += Shipobject.orientation.x * Scalar
        Shipobject.y += Shipobject.orientation.y * Scalar
        return Shipobject
    end

    function UpdatePosition!(Waypointobject::T, Command::Char, Scalar::Int64) where {T <: AbstractWaypoint}
        if Command == 'R' || Command == 'L'
            temp = Waypointobject.x
            Scalar *= CommandRegister[Command][1]
            Waypointobject.x = cosd(Scalar) * Waypointobject.x - sind(Scalar) * Waypointobject.y
            Waypointobject.y = sind(Scalar) * temp + cosd(Scalar) * Waypointobject.y
        else
            Waypointobject.x += Scalar * CommandRegister[Command][1]
            Waypointobject.y += Scalar * CommandRegister[Command][2]
        end
        return Waypointobject
    end

    Manhattandistance(Shipobject::T) where {T <: AbstractShip} = abs(Shipobject.x) + abs(Shipobject.y)

    
    cruiseship = Ship{Float64}(0, 0, 10, 1)
    
    #= open("12. des\\testinput.txt") do io =#
    for line in eachline("12. des\\input.txt")
        Command = line[1]
        if Command == 'F'
            UpdatePosition!(cruiseship, parse(Int64, line[2:end]))
        else
            UpdatePosition!(cruiseship.orientation, Command, parse(Int64, line[2:end]))
        end
    end
    #= end =#
    
    Manhattandistance(cruiseship)
end

@time main()                