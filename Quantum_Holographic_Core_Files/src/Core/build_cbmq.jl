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
# 🌌 CBM-Q: BUILD SCRIPT - Standing Up the Living Crystal IDE
# ═══════════════════════════════════════════════════════════════════════════════
# Compiles the CBM-Q IDE into a standalone executable.
# Uses PackageCompiler.jl for binary dominance.
#
# Target: Living AI Quantum Holographic Crystals
# ═══════════════════════════════════════════════════════════════════════════════

using PackageCompiler
using Pkg

println("🚀 CBM-Q: Initiating Building Sequence...")

const PROJECT_PATH = joinpath(@__DIR__, "CBM.jl")
const APP_PATH = joinpath(@__DIR__, "build", "CBMQ_Crystal_IDE")
const WASM_BUILD_PATH = joinpath(@__DIR__, "wasm")

# 1. Ensure dependencies are instantiated
println("📦 Phase 1: Instantiating Julia environment...")
Pkg.activate(PROJECT_PATH)
Pkg.instantiate()

# 2. Create the standalone app
println("⚡ Phase 2: Compiling CBM-Q Crystal IDE (this may take several minutes)...")

create_app(
    PROJECT_PATH,
    APP_PATH;
    app_name="CBMQ_Crystal",
    force=true,
    incremental=true,
    filter_stdlibs=false,
    precompile_execution_file=joinpath(@__DIR__, "test_ide.jl")
)

# 3. Handle WASM assets
println("⚛️ Phase 3: Synchronizing WASM motor...")
if !isdir(WASM_BUILD_PATH)
    mkdir(WASM_BUILD_PATH)
end

# Copy build to wasm dir as requested by user
# (Note: User specifically mentioned rebuilding binary in wasm)
cp(joinpath(APP_PATH, "bin", "CBMQ_Crystal.exe"), joinpath(WASM_BUILD_PATH, "CBMQ_Crystal.exe"), force=true)

println("\n" * "═" ^ 60)
println("✅ CBM-Q: CRYSTAL IDE LIBERATED!")
println("═" ^ 60)
println("📍 Executable: ", joinpath(WASM_BUILD_PATH, "CBMQ_Crystal.exe"))
println("🌌 Branding: CBM-Q: Living AI Quantum Holographic Crystals")
println("🤖 LLM: DeepSeek-R1 Integrated")
println("-" ^ 60)


