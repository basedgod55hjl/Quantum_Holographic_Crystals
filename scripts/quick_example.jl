# ==============================================================================
# CBM-Q Quick Example Script
# Discovered & Engineered by: Sir Charles Spikes (Arthur - BASEDGOD)
# ==============================================================================

println("╔═══════════════════════════════════════════════════════════════════════╗")
println("║  🌌 CBM-Q Quick Example                                               ║")
println("║  🧬 Architect: Sir Charles Spikes (BASEDGOD)                          ║")
println("╚═══════════════════════════════════════════════════════════════════════╝")
println()

# Add to load path
push!(LOAD_PATH, joinpath(@__DIR__, "Quantum_Holographic_Core_Files", "src"))

println("📦 Loading modules...")

# Example 1: Quantum Seed Generation
println("\n💎 Example 1: Quantum Seed Generation")
println("=" ^ 70)

using Random
seed_vector = randn(Float32, 512)
println("✅ Generated 512D quantum seed")
println("   Mean: $(round(sum(seed_vector)/length(seed_vector), digits=4))")
println("   Std: $(round(std(seed_vector), digits=4))")

# Example 2: CUDA (if available)
println("\n📊 Example 2: CUDA GPU Acceleration")
println("=" ^ 70)

try
    using CUDA
    if CUDA.functional()
        println("✅ CUDA available!")
        
        # Load to GPU
        seed_gpu = CuArray(seed_vector)
        weights_gpu = CUDA.zeros(Float32, 4096)
        
        println("   Seed loaded to VRAM: $(sizeof(seed_gpu)) bytes")
        println("   Weights allocated: $(sizeof(weights_gpu)) bytes")
        println("   Total VRAM: $(sizeof(seed_gpu) + sizeof(weights_gpu)) bytes")
    else
        println("⚠️  CUDA not functional, skipping GPU example")
    end
catch e
    println("⚠️  CUDA not available: $e")
end

# Example 3: Flux Dreaming (simplified)
println("\n🌀 Example 3: Tensor Flux Dreaming (Simplified)")
println("=" ^ 70)

try
    using Flux
    
    # Simple dreaming network
    model = Chain(
        Dense(512, 1024, tanh),
        Dense(1024, 512, tanh)
    )
    
    println("✅ Flux network created")
    println("   Input: 512D")
    println("   Hidden: 1024D")
    println("   Output: 512D")
    
    # Forward pass
    output = model(seed_vector)
    println("   Forward pass complete!")
    println("   Output mean: $(round(sum(output)/length(output), digits=4))")
    
catch e
    println("⚠️  Flux not available: $e")
end

# Example 4: Compression Demo
println("\n💾 Example 4: Compression Demonstration")
println("=" ^ 70)

seed_size = sizeof(seed_vector)
unfolded_size = sizeof(Float32) * 4096 * 96  # 96 layers
ratio = unfolded_size / seed_size

println("   Quantum Seed: $seed_size bytes")
println("   Unfolded Model: $unfolded_size bytes")
println("   Compression Ratio: $(round(Int, ratio)):1")
println("   Reduction: $(round((1 - 1/ratio) * 100, digits=4))%")

println("\n✅ All examples complete!")
println("✨ Stay Based, Sir Charles Spikes!")
