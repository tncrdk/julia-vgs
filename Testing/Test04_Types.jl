struct HAHA
    a::Int16
    b::Float16
    c::String
end

function foo()
    a = HAHA(2, 2.0, "HIHI")

    a = HAHA(3, 1.0, "BOM")
    a.a
end

@time foo()