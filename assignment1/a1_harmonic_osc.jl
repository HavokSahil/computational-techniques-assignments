using Plots

function solveHarmonic(dt, k, m, x0, v0, tmax)
    t = (0:dt:tmax)
    N = length(t)
    res = zeros(N, 1)

    x1 = v0 * dt + x0
    res[1] = x0;
    res[2] = x1;

    for i = 3:N
        res[i] = res[i-1] * (2 - k*dt*dt/m) - res[i-2]
    end

    t, res
end


m = 0.5
k = 2.0
x0 = 1.0
v0 = 0.5
tmax = 10.0

t1, res1 = solveHarmonic(0.5, k, m, x0, v0, tmax);
t2, res2 = solveHarmonic(0.1, k, m, x0, v0, tmax);
t3, res3 = solveHarmonic(0.01, k, m, x0, v0, tmax);
t4, res4 = solveHarmonic(0.001, k, m, x0, v0, tmax);

# Compute the analytical solution of the differential equation
A = sqrt(m*v0*v0/k + x0*x0)
freq = sqrt(k/m)
phase = asin(x0/A)
ares = A .* sin.(freq .* t4 .+ phase)

# Compute the log absolute deviations
dev1 = log.(abs.(A * sin.(freq * t1 .+ phase) .- res1))
dev2 = log.(abs.(A * sin.(freq * t2 .+ phase) .- res2))
dev3 = log.(abs.(A * sin.(freq * t3 .+ phase) .- res3))
dev4 = log.(abs.(A * sin.(freq * t4 .+ phase) .- res4))

p1 = plot(t1, res1, label="dt=0.5",
          title="Solutions of diff. equation m.x''(t) = -kx",
          titlefontsize=10,
          xlabel="Time (s)",
          guidefontsize=8,
          ylabel="Position (x(t))",
          background_color=:black)

plot!(p1, t2, res2, label="dt=0.1")
plot!(p1, t3, res3, label="dt=0.01")
plot!(p1, t4, res4, label="dt=0.001")
plot!(p1, t4, ares, label="analytical")

p2 = plot(t1, dev1, label="dt=0.5",
          title="Log absolute deviation of the numerical solution from analytical solution",
          titlefontsize=10,
          xlabel="Time (s)",
          guidefontsize=8,
          ylabel="Log absolute error",
          background_color=:black)

plot!(p2, t2, dev2, label="dt=0.1")
plot!(p2, t3, dev3, label="dt=0.01")
plot!(p2, t4, dev4, label="dt=0.001")

plot(p1, p2, layout=(2, 1), size=(800, 600))
