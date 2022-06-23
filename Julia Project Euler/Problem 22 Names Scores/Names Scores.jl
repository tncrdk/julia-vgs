using BenchmarkTools

function Formatting(Filepath::String)
    return open(Filepath) do file
        return sort(split(replace(read(file, String), "\"" => ""), ","))
    end
end

function NameScores(Filepath::String)
    ListOfNames = Formatting(Filepath)
    TotalScore::Int64 = 0
    Alphabet = String('A':'Z')
    for name_index in eachindex(ListOfNames)
        NameScore::Int64 = 0
        for letter in ListOfNames[name_index]
            NameScore += findfirst(isequal(letter), Alphabet)
        end
        TotalScore += NameScore * name_index
    end
    return TotalScore
end

link = "C:\\Users\\thorb\\Documents\\Julia\\Julia Project Euler\\Problem 22 Names Scores\\names.txt"

@time NameScores(link)
