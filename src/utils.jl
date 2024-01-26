function Coloring(𝒞)
    """
    Docs
    Input:

    Output:
    """
    n = size(𝒞)[1]
    Cᵗ⁺¹ = BigFloat.(zeros(n))
    𝒬 = unique(𝒞, dims=1)
    for q ∈ 1:size(𝒬)[1]
        for i ∈ 1:n
            if 𝒬[q, :] == 𝒞[i, :]
                Cᵗ⁺¹[i] = q
            end
        end
    end
    return Cᵗ⁺¹
end


function construct_graph(graph)
    x₀ = BigFloat.(ones(Int, nv(graph)))
    edge_index = zeros(Int, 2, ne(graph))
    for (i, edge) in zip(1:ne(graph), edges(graph))
        edge_index[1, i] = edge.src
        edge_index[2, i] = edge.dst
    end
    return x₀, edge_index
end

function graphPloting(A, P, c=nothing, title="")
    flag = true
    plt = nothing
    for i ∈ 1:size(A)[1]
        for j ∈ 1:size(A)[2]
            if A[i,j] == 1
                if flag
                    plt = plot([P[i,1], P[j,1]], [P[i,2], P[j,2]], color="black", linewidth=1, label="", showaxis=false, formatter=Returns(""), title=title, dpi=150)
                    flag = false
                else plot!([P[i,1], P[j,1]], [P[i,2], P[j,2]], color="black", linewidth=1, label="")
                end
            end
        end
    end
    for i ∈ 1:size(P)[1] # ERROR NO PLOTEA CUANDO A = 0
        if isnothing(c) scatter!([P[i,1]], [P[i,2]], markersize=10, label=i)
        else scatter!([P[i,1]], [P[i,2]], markersize=10, label=i, c=c[i])
        end
    end
    return plt
end