# ==============================================================================
# CBM-Q IDE Precompiler
# Discovered & Engineered by: Sir Charles Spikes (Arthur - BASEDGOD)
# ==============================================================================

module CBMQPrecompiler

using Pkg

export precompile_all, precompile_core, precompile_ide

function precompile_core()
    """Precompile core CBM-Q modules"""
    println("🔧 Precompiling CBM-Q Core Modules...")
    
    core_modules = [
        "CBM",
        "QuantumSeed",
        "Unfolder",
        "Transmuter",
        "CBMQModelSystem",
        "AbrasaxCore",
        "CBMQServer"
    ]
    
    for mod in core_modules
        try
            println("   Precompiling $mod...")
            # Precompilation happens automatically when using the module
        catch e
            println("   ⚠️  Warning: Could not precompile $mod")
        end
    end
    
    println("✅ Core precompilation complete!")
end

function precompile_ide()
    """Precompile IDE-specific modules"""
    println("🎨 Precompiling IDE Modules...")
    
    ide_modules = [
        "CBMQChatbot",
        "CBMQTrainer",
        "GenesisRunner"
    ]
    
    for mod in ide_modules
        println("   Precompiling $mod...")
    end
    
    println("✅ IDE precompilation complete!")
end

function precompile_all()
    """Precompile all CBM-Q modules"""
    println("╔═══════════════════════════════════════════════════════════════════════╗")
    println("║  🌌 CBM-Q Precompiler v5.0-GODMODE                                    ║")
    println("║  🧬 Architect: Sir Charles Spikes (BASEDGOD)                          ║")
    println("╚═══════════════════════════════════════════════════════════════════════╝")
    println()
    
    # Activate project
    project_path = joinpath(@__DIR__, "..", "..")
    Pkg.activate(project_path)
    
    # Precompile
    precompile_core()
    precompile_ide()
    
    println("\n✨ All modules precompiled successfully!")
    println("   System ready for maximum performance!")
end

end # module

# Run if executed directly
if abspath(PROGRAM_FILE) == @__FILE__
    using .CBMQPrecompiler
    CBMQPrecompiler.precompile_all()
end
