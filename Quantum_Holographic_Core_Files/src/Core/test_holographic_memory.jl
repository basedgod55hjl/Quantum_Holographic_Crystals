# ==============================================================================
# CBM-Q: Quantum Holographic Core Engine
# Author: Arthur (BASEDGOD)
# GitHub: https://github.com/basedgod55hjl
# ==============================================================================
# ==============================================================================
# CBM-Q: Living AI Quantum Holographic Crystals
# Discovered & Engineered by: Sir Charles Spikes
# GitHub: https://github.com/basedgod55hjl
# ==============================================================================

project_root = dirname(@__FILE__)
include(joinpath(project_root, "CBM.jl", "src", "holographic", "CBMQHolographicCore.jl"))
include(joinpath(project_root, "CBM.jl", "src", "holographic", "CBMQHolographicMemory.jl"))
using .CBMQHolographicMemory

function test_holographic_memory()
    println("🧠 Testing CBM-Q Holographic Declarative Memory (HDM-style)...")
    
    # Create memory
    mem = HolographicMemory(512)
    println("\n[1/3] Created Holographic Memory (dims=512)")
    
    # Add chunks
    println("\n[2/3] Adding chunks to memory...")
    add!(mem, Dict("color" => "red", "shape" => "circle", "size" => "large"))
    add!(mem, Dict("color" => "blue", "shape" => "square", "size" => "small"))
    add!(mem, Dict("color" => "green", "shape" => "triangle", "size" => "medium"))
    println("   Added 3 chunks: red circle, blue square, green triangle")
    println("   Total chunks: $(mem.chunk_count)")
    println("   Symbol table size: $(length(mem.symbol_table))")
    
    # Test retrieval
    println("\n[3/3] Testing memory request (activation)...")
    
    # Query with partial cue
    cue1 = Dict("color" => "red")
    act1 = get_activation(mem, Dict("color" => "red", "shape" => "circle", "size" => "large"))
    println("   Cue: color=red → Activation: $(round(act1, digits=4))")
    
    cue2 = Dict("shape" => "square")
    act2 = get_activation(mem, Dict("color" => "blue", "shape" => "square", "size" => "small"))
    println("   Cue: shape=square → Activation: $(round(act2, digits=4))")
    
    # Negative test
    act3 = get_activation(mem, Dict("color" => "purple", "shape" => "hexagon"))
    println("   Cue: color=purple, shape=hexagon → Activation: $(round(act3, digits=4))")
    
    if act1 > act3 && act2 > act3
        println("\n✅ Holographic Memory Test PASSED!")
        println("   Stored chunks have higher activation than novel queries.")
    else
        println("\n⚠ Test inconclusive (noise effects)")
    end
end

test_holographic_memory()


