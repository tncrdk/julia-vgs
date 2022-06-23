function open_file()
    open("C:\\Users\\thorb\\Documents\\Project Euler\\Grid\\Tall.txt") do file
        println(read(file, String))
    end
end

open_file()