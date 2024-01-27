using LinearAlgebra
using Plots
using Colors
include("message_passing.jl")


function WeisfeilerLehman(C⁰, edge_index, P=nothing, plot=false)
    """
    Implementation of the Weisfeiler Leman algorithm
    Input:  A ∈ ℝˡˣⁿ: defines the underlying graph connectivity/message passing flow. holds the indices of a general (sparse)
            assignment matrix of shape :obj:`[N, M]`.
            P ∈ ℝᵈˣᵈ:
            plot: Boolean, true if a plot is desired
    Output  C ∈ ℕᵈ: Collection of all colorings
    """
    C¹ = WLKernel(C⁰, edge_index)
    C = [C⁰, C¹]
    while C[end] != C[end-1]
        Cᵗ⁺¹ = WLKernel(C[end], edge_index)
        push!(C, Cᵗ⁺¹)
    end
    return length(C[1:end-1])-1, C[end]
end


function  WLKernel(Cᵗ, edge_index)
    """
    Docs
    Input:

    Output:
    """
    ℳ = MessagePassing(Cᵗ, edge_index, true)
    Cᵗ⁺¹ = Hashing(Cᵗ, ℳ)
    return Cᵗ⁺¹
end


function Hashing(Cᵗ, ℳ)
    """
    Docs
    Input:

    Output:
    """

    Cᵗ⁺¹ = hcat(Cᵗ, ℳ)
    # display(Cᵗ⁺¹)
    Cᵗ⁺¹ = Coloring(Cᵗ⁺¹)
    # display(Cᵗ⁺¹)

    return Cᵗ⁺¹
end