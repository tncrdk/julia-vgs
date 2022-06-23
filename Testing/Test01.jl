function foo()
    a = [i for i = 1:10 if i % 2 == 0]
    return a
end

@time foo()