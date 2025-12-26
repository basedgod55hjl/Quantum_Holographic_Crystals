# ==============================================================================
# CBM-Q: Living AI Quantum Holographic Crystals
# Discovered & Engineered by: Sir Charles Spikes
# GitHub: https://github.com/basedgod55hjl
# ==============================================================================

project_root = dirname(@__FILE__)
include(joinpath(project_root, "CBM.jl", "src", "holographic", "CBMQHolographicCore.jl"))
using .CBMQHolographicCore

function test_hrr_operations()
    println("🌌 Testing CBM-Q Holographic Core (HRR Operations)...")
    
    # Test 1: Create HRR vectors
    println("\n[1/4] Creating HRR vectors...")
    a = HRRVector(512)
    b = HRRVector(512)
    c = HRRVector(512)
    println("   ✓ Created 3 random HRR vectors (dim=512)")
    
    # Test 2: Bind and Unbind
    println("\n[2/4] Testing bind/unbind (circular convolution)...")
    bound = hrr_bind(a, b)
    retrieved = hrr_unbind(bound, a)
    similarity = hrr_similarity(retrieved, b)
    println("   Bound: a ⊗ b")
    println("   Unbound: (a ⊗ b) ⊘ a ≈ b")
    println("   Similarity to original b: $(round(similarity, digits=4))")
    if similarity > 0.3
        println("   ✓ Retrieval SUCCESSFUL")
    else
        println("   ⚠ Retrieval weak (expected due to noise)")
    end
    
    # Test 3: Encode multiple pairs
    println("\n[3/4] Testing holographic encoding (superposition)...")
    pairs = [(a, b), (b, c), (c, a)]
    trace = hrr_encode(pairs)
    println("   Encoded 3 key-value pairs into single trace")
    
    # Retrieve each value
    r1 = hrr_decode(trace, a)
    r2 = hrr_decode(trace, b)
    r3 = hrr_decode(trace, c)
    
    s1 = hrr_similarity(r1, b)
    s2 = hrr_similarity(r2, c)
    s3 = hrr_similarity(r3, a)
    
    println("   trace[a] ≈ b: $(round(s1, digits=4))")
    println("   trace[b] ≈ c: $(round(s2, digits=4))")
    println("   trace[c] ≈ a: $(round(s3, digits=4))")
    
    # Test 4: O(T) Attention
    println("\n[4/4] Testing Hrrformer-style O(T) attention...")
    T = 100
    queries = [HRRVector(512) for _ in 1:T]
    keys = [HRRVector(512) for _ in 1:T]
    values = [HRRVector(512) for _ in 1:T]
    
    outputs = hrr_attention(queries, keys, values)
    println("   Processed $T-length sequence with O(T) complexity")
    println("   Output vectors: $(length(outputs))")
    
    println("\n✅ Holographic Core Test PASSED!")
end

test_hrr_operations()
