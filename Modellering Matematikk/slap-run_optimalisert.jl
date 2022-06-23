const air_drag_coefficient = 0.3
const area = 0.0042
const air_density = 1.225
const mass = 0.145
const g = 9.81
const y0 = 1.6
const x0 = 0.0

const time_step_size = 0.0001
const target_distance = 177.3936
const accuracy = 0.00001

mutable struct Ball{T<:Float64}
    x_pos::T
    y_pos::T
    velocity::T
    x_vel::T
    y_vel::T
    mass::T
    area::T
    air_drag_coefficient::T
end
Ball(x::T, y::T, v::T, θ::T) where {T<:Float64} = Ball(x, y, v, v * cos(θ), v * sin(θ), mass, area, air_drag_coefficient)
Ball(v::Float64, θ::Float64) = Ball(x0, y0, v, v * cos(θ), v * sin(θ), mass, area, air_drag_coefficient)
Ball(v::Float64) = Ball(v, pi / 4)


airdrag_acceleration(v::Float64, ball::Ball) = ball.area * ball.air_drag_coefficient * air_density * v^3 / (2 * ball.mass * abs(v))
x_acceleration(ball::Ball) = -airdrag_acceleration(ball.x_vel, ball)
y_acceleration(ball::Ball) = -airdrag_acceleration(ball.y_vel, ball) - g

𝚫x_velocity(ball::Ball, δt::Float64) = x_acceleration(ball) * δt
𝚫y_velocity(ball::Ball, δt::Float64) = y_acceleration(ball) * δt

𝚫x_distance(ball::Ball, δt::Float64) = ball.x_vel * δt + 0.5 * x_acceleration(ball) * δt^2
𝚫y_distance(ball::Ball, δt::Float64) = ball.y_vel * δt + 0.5 * y_acceleration(ball) * δt^2

function simulate_throw!(ball::Ball, δt::Float64)
    while ball.y_pos >= 0
        ball.x_pos += 𝚫x_distance(ball, δt)
        ball.y_pos += 𝚫y_distance(ball, δt)

        ball.x_vel += 𝚫x_velocity(ball, δt)
        ball.y_vel += 𝚫y_velocity(ball, δt)
    end
    return ball.x_pos
end

function refreshball!(ball::Ball, v0::Float64)
    ball.x_pos, ball.y_pos = x0, y0
    ball.velocity = v0
    ball.x_vel = v0 * cos(pi / 4)
    ball.y_vel = v0 * sin(pi / 4)
end

function hit_target(target::Float64, v0_guess::Float64, δt::Float64, accuracy::Float64)
    reference_ball = Ball(v0_guess)
    result = simulate_throw!(reference_ball, δt)
    solution = v0_guess
    diff = target - result

    while abs(result - target) >= accuracy
        solution += diff / target
        refreshball!(reference_ball, solution)
        result = simulate_throw!(reference_ball, δt)
        diff = target - result
    end

    return solution, result
end

function main()
    v, d = hit_target(target_distance, 40.0, time_step_size, accuracy)
    println("Fart: $v (m/s) / $(v*3.6) (km/h)")
    println("Distanse: $d m")
end

@time main()