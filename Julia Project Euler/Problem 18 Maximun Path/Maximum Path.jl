
function Formatting(link::String)
    file_str::String = open(link) do file
        return read(file, String)
    end
    return [[parse(Int64, x) for x in split(i, " ")] for i in split(file_str, "\r\n")]
end

function FindMaxPath(txt::Vector{Vector{Int64}})
    for row = length(txt):-1:1
        for index = 1:(length(txt[row])-1)
            if txt[row][index] > txt[row][index+1]
                txt[row-1][index] += txt[row][index]
            else
                txt[row-1][index] += txt[row][index+1]
            end
        end
    end

    println(txt[1][1])
end

link = "C:\\Users\\thorb\\Documents\\Julia\\Julia Project Euler\\Problem 18 Maximun Path\\TriangleBIG.txt"

@time FindMaxPath(Formatting(link))
