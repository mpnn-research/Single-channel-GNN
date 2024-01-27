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
    """
    Docs
    Input:

    Output:
    """
    x₀ = BigFloat.(ones(Int, nv(graph)))
    edge_index = zeros(Int, 2, ne(graph))
    for (i, edge) in zip(1:ne(graph), edges(graph))
        edge_index[1, i] = edge.src
        edge_index[2, i] = edge.dst
    end
    return x₀, edge_index
end


function WL_vs_GNN(graph, γ, verbose=false)
    """
    Docs
    Input:

    Output:
    """
    x₀, edge_index = construct_graph(graph)
    iters, coloring_wl = WeisfeilerLehman(x₀, edge_index)
    coloring_gnn = MPGNN(x₀, edge_index, γ, iters)
    if coloring_wl != coloring_gnn && verbose
        println("Iters: $(iters), P: $(P[i]), N: $(N[j])")
        println(coloring_wl)
        println(coloring_gnn)
        println(maximum(coloring_wl))
        println(maximum(coloring_gnn))
        println(minimum(degree(graphs[i][j])))
        println(degree(graphs[i][j]))
    end
    return coloring_wl == coloring_gnn
end

function Regression(a, b)
    A = hcat(ones(length(a)), a)
    return inv(A' * A) * A' * b
end