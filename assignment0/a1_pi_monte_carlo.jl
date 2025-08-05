using Plots, LinearAlgebra

function computePI(iterations)
    count_in = 0
    count_all = 0

    inpoints = Array{Float64}(undef, 0, 2)
    outpoints = Array{Float64}(undef, 0, 2)

    for i = 1:iterations
        x = rand()
        y = rand()
        d = norm([x, y]);

        if d <= 1.0
            count_in += 1
            inpoints = [inpoints; [x, y]']
        else
            outpoints = [outpoints; [x, y]']
        end

        count_all += 1
    end

    res = 4 * count_in / count_all
    res, inpoints, outpoints
end

iterations = 64
p = Any[]

for i = 1:4
    res, inpoints, outpoints = computePI(iterations)
    p1 = scatter(inpoints[:, 1], inpoints[:, 2],
                 markersize=i<3 ? 3 : 1,
                 markercolor=:blue,
                 aspect_ratio=1,
                 markerstrokewidth=0,
                 legendfontsize=4,
                 legend=:topright,
                label="inner points")
    scatter!(outpoints[:, 1], outpoints[:, 2],
             markersize=i<3 ? 3 : 1,
             markercolor=:red,
             markerstrokewidth=0,
             label="outer points")
    push!(p, p1)
    iterations *= 10
end
plot(p..., layout=(2, 2))
