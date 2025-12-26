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

# ═══════════════════════════════════════════════════════════════════════════════
# 🌌 CBM-Q: Official Native Julia Launcher
# ═══════════════════════════════════════════════════════════════════════════════
# This script initializes the CBM-Q Sovereign Intelligence, manifests the
# CBM Studio environment, and launches the interactive manifold workbench.
# 
# Usage: julia launch_cbm_q.jl
# ═══════════════════════════════════════════════════════════════════════════════

using Pkg

# 1. Initialize Environment
println("🚀 Initializing CBM-Q Environment...")
Pkg.activate("CBM.jl")

# Check if dependencies are installed, if not, instantiate
if !isfile("CBM.jl/Manifest.toml")
    println("📦 First-time setup detected. Instantiating project ecosystem...")
    Pkg.instantiate()
end

# 2. Load Core System
include("CBM.jl/src/CBM.jl")
using .CBM

# 3. Manifest Studio
println("\n🎨 Manifesting Studio Dashboard...")
studio = StudioEnvironment()
launch_studio(studio)

# 4. Entry Logic
if length(ARGS) > 0 && ARGS[1] == "--demo"
    demo()
else
    welcome()
    println("\n" * "═" ^ 65)
    println("🌟 SOVEREIGN REPL READY")
    println("═" ^ 65)
    println("   Type 'CBM.demo()' to see the system in action.")
    println("   Type 'studio' to inspect the dashbord state.")
    println("   Type 'exit()' to leave the manifold.")
    println()
end

# Keep variables available in REPL if run interactively
# julia -i launch_cbm_q.jl


