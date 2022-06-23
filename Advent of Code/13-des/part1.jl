using BenchmarkTools

function main()
    function Formatting(link::String)
        return open(link) do io
            timestamp = parse(Int64, readline(io))
            busses =  [parse(Int64, i) for i in split(replace(readline(io), "x," => ""), ",")]
            return timestamp, busses
        end
    end

    ExtraMinutes(timestamp::Int64, busid::Int64) = busid - (timestamp % busid)

    function CheckEveryBus(timestamp::Int64, busses::Vector{Int64})
        ExtraMinutesRecord = timestamp
        RecordBus = 0
        
        for busid in busses
            temp = ExtraMinutes(timestamp, busid)
            if temp < ExtraMinutesRecord
                ExtraMinutesRecord = temp
                RecordBus = busid
            end
        end

        println("$RecordBus => $ExtraMinutesRecord")
        println(RecordBus * ExtraMinutesRecord)
    end

    timestamp, busses = Formatting("13-des\\input.txt")
    CheckEveryBus(timestamp, busses)
end

main()