using LinearAlgebra
using Plots
using Colors
include("message_passing.jl")


function WeisfeilerLehman(C⁰, edge_index, P=nothing, plot=false)
    C¹ = WLKernel(C⁰, edge_index)
    C = [C⁰, C¹]
    while C[end] != C[end-1]
        Cᵗ⁺¹ = WLKernel(C[end], edge_index)
        push!(C, Cᵗ⁺¹)
    end
    return length(C[1:end-1])-1, C[end]
end


function  WLKernel(Cᵗ, edge_index)
    ℳ = MessagePassing(Cᵗ, edge_index, true)
    Cᵗ⁺¹ = Hashing(Cᵗ, ℳ)
    return Cᵗ⁺¹
end


function Hashing(Cᵗ, ℳ)
    Cᵗ⁺¹ = hcat(Cᵗ, ℳ)
    Cᵗ⁺¹ = Coloring(Cᵗ⁺¹)

    return Cᵗ⁺¹
end