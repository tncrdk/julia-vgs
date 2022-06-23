
function Prog()
    function ConvertToString(
        Number::Int,
        Digits::Dict{String,String},
        Ten_nineteen::Dict{String,String},
        Tens::Dict{String,String},
    )
        StringInt = string(Number)
        ReturnString::String = ""

        if length(StringInt) == 1
            return Digits[StringInt]
        elseif length(StringInt) == 2
            if StringInt[1:1] == "1"
                return Ten_nineteen[StringInt]
            else
                return Tens[StringInt[1:1]] * Digits[StringInt[2:2]]
            end
        elseif length(StringInt) == 3
            if StringInt[2:end] == "00"
                return Digits[StringInt[1:1]] * "hundred"
            else
                ReturnString = Digits[StringInt[1:1]] * "hundredand"
                if StringInt[2:2] == "1"
                    ReturnString *= Ten_nineteen[StringInt[2:end]]
                else
                    ReturnString *= Tens[StringInt[2:2]] * Digits[StringInt[end:end]]
                end
                return ReturnString
            end
        else
            return "onethousand"
        end
    end


    Digits = Dict{String,String}(
        "0" => "",
        "1" => "one",
        "2" => "two",
        "3" => "three",
        "4" => "four",
        "5" => "five",
        "6" => "six",
        "7" => "seven",
        "8" => "eight",
        "9" => "nine",
    )
    Ten_nineteen = Dict{String,String}(
        "10" => "ten",
        "11" => "eleven",
        "12" => "twelve",
        "13" => "thirteen",
        "14" => "fourteen",
        "15" => "fifteen",
        "16" => "sixteen",
        "17" => "seventeen",
        "18" => "eighteen",
        "19" => "nineteen",
    )
    Tens = Dict{String,String}(
        "0" => "",
        "2" => "twenty",
        "3" => "thirty",
        "4" => "forty",
        "5" => "fifty",
        "6" => "sixty",
        "7" => "seventy",
        "8" => "eighty",
        "9" => "ninety",
    )
    total_length = 0

    for i = 1:1000
        total_length += length(ConvertToString(i, Digits, Ten_nineteen, Tens))
    end

    println(total_length)
end

@time Prog()
