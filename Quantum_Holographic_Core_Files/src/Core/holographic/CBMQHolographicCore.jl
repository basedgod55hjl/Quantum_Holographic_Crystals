# ==============================================================================
# CBM-Q: Living AI Quantum Holographic Crystals
# Discovered & Engineered by: Sir Charles Spikes
# GitHub: https://github.com/basedgod55hjl
# ==============================================================================

module CBMQHolographicCore

using FFTW
using LinearAlgebra
using Random

export HRRVector, hrr_bind, hrr_unbind, hrr_encode, hrr_decode, hrr_similarity, hrr_permute, hrr_attention

"""
    HRRVector

Holographic Reduced Representation vector with automatic normalization.
"""
struct HRRVector
    data::Vector{ComplexF64}
    dims::Int
    
    function HRRVector(dims::Int)
        # Initialize with random unit-length complex vector
        v = randn(dims) + im * randn(dims)
        v = v / norm(v)
        new(v, dims)
    end
    
    function HRRVector(data::Vector{ComplexF64})
        new(data / norm(data), length(data))
    end
    
    function HRRVector(data::Vector{Float64})
        new(ComplexF64.(data) / norm(data), length(data))
    end
end

# ═══════════════════════════════════════════════════════════════════════════════
# Core HRR Operations: Circular Convolution & Correlation (FFT-based)
# ═══════════════════════════════════════════════════════════════════════════════

"""
    hrr_bind(a, b) -> HRRVector

Bind two HRR vectors using circular convolution.
Result: IFFT(FFT(a) .* FFT(b))
"""
function hrr_bind(a::HRRVector, b::HRRVector)
    @assert a.dims == b.dims "Dimension mismatch"
    result = ifft(fft(a.data) .* fft(b.data))
    return HRRVector(result)
end

function hrr_bind(a::Vector, b::Vector)
    return ifft(fft(a) .* fft(b))
end

"""
    hrr_unbind(trace, cue) -> HRRVector

Retrieve from a holographic trace using circular correlation.
Result: IFFT(conj(FFT(cue)) .* FFT(trace))
"""
function hrr_unbind(trace::HRRVector, cue::HRRVector)
    @assert trace.dims == cue.dims "Dimension mismatch"
    result = ifft(conj.(fft(cue.data)) .* fft(trace.data))
    return HRRVector(result)
end

function hrr_unbind(trace::Vector, cue::Vector)
    return ifft(conj.(fft(cue)) .* fft(trace))
end

# ═══════════════════════════════════════════════════════════════════════════════
# Encoding & Decoding: Superposition of bound pairs
# ═══════════════════════════════════════════════════════════════════════════════

"""
    hrr_encode(pairs) -> HRRVector

Encode multiple key-value pairs into a single holographic trace.
pairs: Vector of (key::HRRVector, value::HRRVector)
"""
function hrr_encode(pairs::Vector{Tuple{HRRVector, HRRVector}})
    if isempty(pairs)
        error("Cannot encode empty pairs")
    end
    
    dims = pairs[1][1].dims
    trace = zeros(ComplexF64, dims)
    
    for (key, value) in pairs
        bound = hrr_bind(key, value)
        trace .+= bound.data
    end
    
    return HRRVector(trace)
end

"""
    hrr_decode(trace, key) -> HRRVector

Decode a value from a holographic trace using a key.
"""
function hrr_decode(trace::HRRVector, key::HRRVector)
    return hrr_unbind(trace, key)
end

# ═══════════════════════════════════════════════════════════════════════════════
# Similarity & Activation (Cosine Similarity)
# ═══════════════════════════════════════════════════════════════════════════════

"""
    hrr_similarity(a, b) -> Float64

Compute the cosine similarity between two HRR vectors.
"""
function hrr_similarity(a::HRRVector, b::HRRVector)
    return real(dot(a.data, b.data)) / (norm(a.data) * norm(b.data))
end

function hrr_similarity(a::Vector, b::Vector)
    return real(dot(a, b)) / (norm(a) * norm(b))
end

# ═══════════════════════════════════════════════════════════════════════════════
# Permutation: Positional Encoding for Sequences
# ═══════════════════════════════════════════════════════════════════════════════

"""
    hrr_permute(v, shift) -> HRRVector

Circular shift (permutation) for positional encoding.
"""
function hrr_permute(v::HRRVector, shift::Int)
    return HRRVector(circshift(v.data, shift))
end

"""
    hrr_inverse_permute(v, shift) -> HRRVector

Inverse permutation for retrieval.
"""
function hrr_inverse_permute(v::HRRVector, shift::Int)
    return HRRVector(circshift(v.data, -shift))
end

# ═══════════════════════════════════════════════════════════════════════════════
# Hrrformer-Style Self-Attention (O(T) Complexity)
# ═══════════════════════════════════════════════════════════════════════════════

"""
    hrr_attention(queries, keys, values) -> Vector{HRRVector}

Single-layer HRR self-attention with O(T) complexity.
Unlike quadratic attention, this uses binding/unbinding for key-value lookup.
"""
function hrr_attention(queries::Vector{HRRVector}, keys::Vector{HRRVector}, values::Vector{HRRVector})
    @assert length(queries) == length(keys) == length(values) "Length mismatch"
    
    T = length(queries)
    dims = queries[1].dims
    
    # Build holographic key-value memory (O(T))
    pairs = [(keys[i], values[i]) for i in 1:T]
    memory_trace = hrr_encode(pairs)
    
    # Query the memory for each position (O(T))
    outputs = HRRVector[]
    for q in queries
        retrieved = hrr_decode(memory_trace, q)
        push!(outputs, retrieved)
    end
    
    return outputs
end

end # module


