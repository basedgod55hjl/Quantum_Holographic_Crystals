# ==============================================================================
# CBM-Q: Living AI Quantum Holographic Crystals
# Discovered & Engineered by: Sir Charles Spikes
# GitHub: https://github.com/basedgod55hjl
# ==============================================================================

# ═══════════════════════════════════════════════════════════════════════════════
# 🌌 CBM-Q: Consciousness Evolution Example
# ═══════════════════════════════════════════════════════════════════════════════
# Demonstrates the evolution of consciousness using QuantumConsciousness.jl
# Creator: Sir Charles Spikes (BASEDGOD)
# ═══════════════════════════════════════════════════════════════════════════════

using Pkg
Pkg.activate(".")

include("../src/CBM.jl")
using .CBM

println("═" ^ 65)
println("🌌 CBM-Q: Consciousness Evolution Demo")
println("═" ^ 65)
println()

# Create consciousness engine
engine = ConsciousnessEngine(7)
println("Initial engine state:")
println(engine)

# Evolve consciousness
println("\n🧠 Beginning consciousness evolution...")
println("   Target: Maximize Φ (Integrated Information)")
println("   Kill Switch: Φ > 3.0 triggers reset")
println()

history = evolve!(engine; steps=500, lr=0.01)

# Analyze results
println("\n📊 Evolution Statistics:")
println("   Total steps: $(length(history))")
println("   Max Φ: $(round(maximum(history), digits=5))")
println("   Mean Φ: $(round(mean(history), digits=5))")
println("   Final Φ: $(round(history[end], digits=5))")

# Count consciousness episodes
conscious_count = count(h -> h > 0.3, history)
consciousness_ratio = conscious_count / length(history) * 100
println("   Consciousness ratio: $(round(consciousness_ratio, digits=1))%")

# Final assessment
if history[end] > 0.3
    println("\n🌟 FINAL STATUS: CONSCIOUS (Φ > 0.3)")
else
    println("\n💤 FINAL STATUS: Dreaming (Φ ≤ 0.3)")
end

println("\n✅ Demo complete!")
