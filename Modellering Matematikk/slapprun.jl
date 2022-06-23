function main()
    k = 0.3
    A = 0.0042
    rho = 1.225
    m = 0.145
    g = 9.81

    air_drag(v::Float64) = rho * A * k * v^2 / (2 * m)

    a_y(v::Float64) = -air_drag(v) - g
    a_x(v::Float64) = -air_drag(v)

    v_x(δt::Float64, v::Float64) = v + a_x(v) * δt
    v_y(δt::Float64, v::Float64) = v + a_y(v) * δt

    𝚫s(δt::Float64, a::Float64, v::Float64) = v * δt + 0.5 * a * δt^2

    function get_distance(v0::Float64)
        Ty = 0
        Tx = 0
        time_step = 0.000001

        Sy = 1.6
        Sx = 0

        θ = pi / 4
        Vy = v0 * sin(θ)
        Vx = v0 * cos(θ)

        while Sy >= 0
            a = a_y(Vy)
            Sy += 𝚫s(time_step, a, Vy)
            Vy = v_y(time_step, Vy)
            Ty += time_step
        end

        while Tx <= Ty
            a = a_y(Vx)
            Sx += 𝚫s(time_step, a, Vx)
            Vx = v_x(time_step, Vx)
            Tx += time_step
        end
        return Sx
    end

    closest_speed = 0
    closest_distance = 0
    closest_diff = 1000
    target = 177.3936
    prev_diff = 1000

    for v0 in 60.5121:0.0001:60.5126
        d = get_distance(v0)
        diff = abs(d - target)
        if diff < closest_diff
            closest_diff = diff
            closest_distance = d
            closest_speed = v0
        end
        if diff > prev_diff
            break
        end
        prev_diff = diff
    end

    return (closest_distance, closest_speed, closest_speed * 3.6)
end

println(main())
