
function check_year(curr_fday::T, days_of_the_months::Vector{T}) where {T<:Integer}
    Sundays = 0
    for month_days in days_of_the_months
        if curr_fday == 7
            Sundays += 1
        end
        curr_fday =
            (curr_fday + month_days % 7) > 7 ? (curr_fday + month_days % 7) % 7 :
            (curr_fday + month_days % 7)
    end
    return Sundays, curr_fday
end

function check_century(curr_day::T, curr_year::T, ending_year::T) where {T<:Integer}
    days_of_the_month_normal = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]
    days_of_the_month_leap = [31, 29, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]
    Sundays = 0
    while curr_year <= ending_year
        if curr_year % 4 == 0
            TempSundays, curr_day = check_year(curr_day, days_of_the_month_leap)
            Sundays += TempSundays
        else
            TempSundays, curr_day = check_year(curr_day, days_of_the_month_normal)
            Sundays += TempSundays
        end

        curr_year += 1
    end
    println(Sundays)
end

@time check_century(2, 1901, 2000)
