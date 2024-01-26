
function MessagePassing(xᵗ, edge_index, multiset=false)
    """
    Docs
    Input:

    Output:
    """
    if multiset ℳ = [[] for _ in 1:length(xᵗ)]
    else ℳ = [[0.] for _ in 1:length(xᵗ)] end
    for edge in eachcol(edge_index)
        xᵢ, xⱼ = edge
        ℳᵢⱼ = Message(xᵗ[xⱼ])
        push!(ℳ[xᵢ], ℳᵢⱼ)
    end
    if multiset ℳ = map(ℳᵢ -> counter(ℳᵢ), ℳ)
    else ℳ = map(ℳᵢ -> Aggregation(ℳᵢ), ℳ) end
    return ℳ
end


function Aggregation(ℳᵢ)
    """
    Docs
    Input:

    Output:
    """
    return reduce(+, ℳᵢ)
end


function Message(xⱼ)
    """
    Docs
    Input:

    Output:
    """
    return xⱼ
end


relu(x::Real) = (x <= 0) * 0 + (x > 0) * x
sgn(x::Real) = (x <= 0) * -1 + (x > 0) * 1
sigmoid(x::Real) = BigFloat(one(x) / (one(x) + exp(-x)))