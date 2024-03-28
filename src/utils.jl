using Primes

function Coloring(𝒞)
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


function WL_vs_GNN(graph, γ)
    x₀, edge_index = construct_graph(graph)
    iters, coloring_wl = WeisfeilerLehman(x₀, edge_index)
    coloring_gnn = MPGNN(x₀, edge_index, γ, iters)
    return sum(coloring_wl) <= sum(coloring_gnn)
end


function Regression(a, b)
    A = hcat(ones(length(a)), a)
    return inv(A' * A) * A' * b
end


function label_encoder(X)
    n, d = size(X)
    H = ones(n)
    𝒬 = unique(X, dims=1)
    for q ∈ 1:size(𝒬)[1]
        for i ∈ 1:n
            if 𝒬[q, :] == X[i, :]
                H[i] = sqrt(prime(q))
            end
        end
    end
    return H
end
