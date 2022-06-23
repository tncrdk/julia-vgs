
function factorial(n)
    b::BigInt = 1
    for i = 1:n
        b *= i
    end
    b
end

function main()
    big_num = string(factorial(100))
    sum = 0
    for i in big_num
        sum += parse(Int64, i)
    end
    sum
end

@time main()
