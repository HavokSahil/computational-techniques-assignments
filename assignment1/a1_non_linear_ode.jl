using Plots

x0 = 1.0
v0 = 0.5
k = -0.4
m = 1.0
l = 0.3
b = 0.3
F0 = 1.0
w = 1.0
dt = 0.01
tmax = 50.0

t = (0:dt:tmax)
N = length(t)
res = zeros(N, 1)

res[1] = x0;
res[2] = x0 + v0 * dt

c = 1+b*dt/m
c1 = (2 - k*dt/m + b*dt/m)/c
c2 = -l*dt*dt/(c*m)
c3 = -1/c
c4 = F0*dt*dt/(c*m)

for i = 3:N
    res[i] = c1*res[i-1] +
        c2*(res[i-1]^3) +
        c3*res[i-2] +
        c4*cos(w*t[i])
end

p = plot(t, res,
         title="Position-time solution curve for non-linear second order ode",
         label="Solution",
         xlabel="Time (s)",
         ylabel="Position (x(t))",
         titlefontsize=8,
         guidefontsize=8,
         background_color=:black)
