using Plots

function solveEqn(dt, x0, k, tmax)
    t = (0:dt:tmax)
    N = length(t)
    res = zeros(N, 1)

    for i = 1:N
        if i == 1
            res[i] = x0
        else
            res[i] = res[i-1] * (1-k*dt)
        end
    end
    return t, res
end

x0 = 4.0
k = 2.0
tmax = 2.5

t1, res1 = solveEqn(0.5, x0, k, tmax)
t2, res2 = solveEqn(0.1, x0, k, tmax)
t3, res3 = solveEqn(0.01, x0, k, tmax)
t4, res4 = solveEqn(0.001, x0, k, tmax)
ares = x0 * exp.(-k * t4)
errnum1 = log.(x0 * exp.(-k * t1) - res1)
errnum2 = log.(x0 * exp.(-k * t2) - res2)
errnum3 = log.(x0 * exp.(-k * t3) - res3)
errnum4 = log.(x0 * exp.(-k * t4) - res4)

p1 = plot(t1, res1, label="dt=0.5",
          title="Solutions of diff. equation x'(t) = -kx",
          titlefontsize=10,
          xlabel="Time (s)",
          guidefontsize=8,
          ylabel="Position (x(t))",
          background_color=:black)

plot!(p1, t2, res2, label="dt=0.1")
plot!(p1, t3, res3, label="dt=0.01")
plot!(p1, t4, res4, label="dt=0.001")
plot!(p1, t4, ares, label="analytical")

p2 = plot(t1, errnum1, label="dt=0.5",
          title="Log deviation of the numerical solution from analytical solution",
          titlefontsize=10,
          xlabel="Time (s)",
          guidefontsize=8,
          ylabel="Error",
          background_color=:black)

plot!(p2, t2, errnum2, label="dt=0.1")
plot!(p2, t3, errnum3, label="dt=0.01")
plot!(p2, t4, errnum4, label="dt=0.001")

plot(p1, p2, layout=(2, 1), size=(800, 600))


#=
The plot function customization in julia Plots
plot(x, y;
    title="My Plot Title",
    xlabel="Time (s)",
    ylabel="Value",
    label="dt = 0.1",
    legend=:topright,
    grid=true,
    linewidth=2,
    linestyle=:dash,
    color=:red,
    marker=:circle,
    markersize=4,
    xlims=(0, 10),
    ylims=(0, 5),
    background_color=:white,
)
=#
