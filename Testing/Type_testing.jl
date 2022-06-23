abstract type AbstractPerson end
abstract type AbstractStudent <: AbstractPerson end
abstract type AbstractTeacher <: AbstractPerson end

struct Person <: AbstractPerson
    name::String
end

struct Student <: AbstractStudent
    name::String
    age::Int
    courses::Vector{String}
end

struct Teacher <: AbstractTeacher
    name::String
    age::Int
    teachings::Vector{String}
end

struct MusicStudent <: AbstractStudent
    age::Int
end

function (SomePerson::AbstractPerson)(x::String)
    println("Hello $x")
end

(SomePerson::AbstractPerson)() = SomePerson("Thorbjorn")


get_name(structure::AbstractPerson) = structure.name
get_name(structure::MusicStudent) = "No Name"

get_age(structure::AbstractPerson) = structure.age



function main()
    t1 = Teacher("Ehh", 45, ["Something", "Ahh"])
    s1 = Student("Ahh", 18, ["a", "e"])
    get_age(t1)
    t1()
    s1("Tor")
end


main()