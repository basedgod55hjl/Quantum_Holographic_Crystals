# ==============================================================================
# CBM-Q: Living AI Quantum Holographic Crystals
# Discovered & Engineered by: Sir Charles Spikes
# GitHub: https://github.com/basedgod55hjl
# ==============================================================================

module CBMQHolographicMemory

include("CBMQHolographicCore.jl")
using .CBMQHolographicCore
using LinearAlgebra

export HolographicMemory, add!, request, get_activation, clear!

"""
    HolographicMemory

ACT-R style Holographic Declarative Memory using HRR.
Inspired by HDM (Matthew A. Kelly).
"""
mutable struct HolographicMemory
    trace::Vector{ComplexF64}
    dims::Int
    chunk_count::Int
    symbol_table::Dict{String, HRRVector}
    
    function HolographicMemory(dims::Int=512)
        new(zeros(ComplexF64, dims), dims, 0, Dict{String, HRRVector}())
    end
end

"""
    get_or_create_symbol(mem, name) -> HRRVector

Get or create a symbol vector for a given name.
"""
function get_or_create_symbol(mem::HolographicMemory, name::String)
    if haskey(mem.symbol_table, name)
        return mem.symbol_table[name]
    else
        sym = HRRVector(mem.dims)
        mem.symbol_table[name] = sym
        return sym
    end
end

"""
    add!(mem, chunk)

Add a chunk (dict of slot-value pairs) to holographic memory.
Example: add!(mem, Dict("color" => "red", "shape" => "circle"))
"""
function add!(mem::HolographicMemory, chunk::Dict{String, String})
    chunk_trace = zeros(ComplexF64, mem.dims)
    
    for (slot, value) in chunk
        slot_vec = get_or_create_symbol(mem, slot)
        value_vec = get_or_create_symbol(mem, value)
        bound = hrr_bind(slot_vec, value_vec)
        chunk_trace .+= bound.data
    end
    
    # Normalize and add to global trace
    chunk_trace = chunk_trace / norm(chunk_trace)
    mem.trace .+= chunk_trace
    mem.chunk_count += 1
    
    return nothing
end

"""
    request(mem, cue) -> Dict{String, Float64}

Request a retrieval from memory using a partial cue.
Returns a dict of symbol activations.
"""
function request(mem::HolographicMemory, cue::Dict{String, String})
    if mem.chunk_count == 0
        return Dict{String, Float64}()
    end
    
    # Build cue trace
    cue_trace = zeros(ComplexF64, mem.dims)
    for (slot, value) in cue
        slot_vec = get_or_create_symbol(mem, slot)
        value_vec = get_or_create_symbol(mem, value)
        bound = hrr_bind(slot_vec, value_vec)
        cue_trace .+= bound.data
    end
    cue_trace = cue_trace / norm(cue_trace)
    
    # Compute similarity with memory trace
    similarity = hrr_similarity(mem.trace, cue_trace)
    
    # Return activations for all known symbols
    activations = Dict{String, Float64}()
    for (name, vec) in mem.symbol_table
        # Unbind each slot to see what values are activated
        retrieved = hrr_unbind(mem.trace, vec)
        # Find best matching symbol
        best_match = ""
        best_sim = -Inf
        for (other_name, other_vec) in mem.symbol_table
            sim = hrr_similarity(retrieved, other_vec)
            if sim > best_sim
                best_sim = sim
                best_match = other_name
            end
        end
        activations[name] = best_sim
    end
    
    return activations
end

"""
    get_activation(mem, chunk) -> Float64

Get the activation (cosine similarity) of a chunk in memory.
"""
function get_activation(mem::HolographicMemory, chunk::Dict{String, String})
    if mem.chunk_count == 0
        return 0.0
    end
    
    chunk_trace = zeros(ComplexF64, mem.dims)
    for (slot, value) in chunk
        slot_vec = get_or_create_symbol(mem, slot)
        value_vec = get_or_create_symbol(mem, value)
        bound = hrr_bind(slot_vec, value_vec)
        chunk_trace .+= bound.data
    end
    chunk_trace = chunk_trace / norm(chunk_trace)
    
    return hrr_similarity(mem.trace, chunk_trace)
end

"""
    clear!(mem)

Clear all memory contents.
"""
function clear!(mem::HolographicMemory)
    mem.trace .= 0
    mem.chunk_count = 0
    empty!(mem.symbol_table)
    return nothing
end

end # module
