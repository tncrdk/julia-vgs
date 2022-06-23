function MainProg()
    function sum_arg(x)
        s = 0.0
        for i in x
            s += i
        end
        return s
    end;

    x = rand(1000);

    return sum_arg(x)
end

@time MainProg()