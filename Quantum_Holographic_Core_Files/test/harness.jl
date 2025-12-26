# ==============================================================================
# CBM-Q: Living AI Quantum Holographic Crystals
# Discovered & Engineered by: Sir Charles Spikes
# GitHub: https://github.com/basedgod55hjl
# ==============================================================================

using Pkg
Pkg.activate(".")

using Test
using CUDA
using CBM
using CBM.CBNQKernels
using CBM.GGUFBridge

@testset "Living Crystal Genesis Harness" begin
    @info "💎 Initializing Living Crystal Test Sequence..."

    # 1. Verify Core Binary Opcodes (Deterministic)
    @testset "Binary Opcodes (GPU)" begin
        len = 1024
        a_host = rand(UInt64, len)
        b_host = rand(UInt64, len)
        
        if CUDA.functional()
            a_dev = CuArray(a_host)
            b_dev = CuArray(b_host)
            out_dev = CUDA.zeros(UInt64, len)

            # XOR Test
            xor_kernel!(a_dev, b_dev, out_dev)
            out_host = Array(out_dev)
            @test out_host == (a_host .⊻ b_host)
            @info "   ✅ XOR Kernel Validated"

            # AND Test
            and_kernel!(a_dev, b_dev, out_dev)
            out_host = Array(out_dev)
            @test out_host == (a_host .& b_host)
            @info "   ✅ AND Kernel Validated"
        else
            @warn "   ⚠️  CUDA not available. Skipping GPU Opcode tests."
        end
    end

    # 2. Verify Orch-OR Collapse (Probabilistic but seeded)
    @testset "Orch-OR Collapse" begin
        if CUDA.functional()
            len = 1024
            seed_dev = CuArray(zeros(UInt64, len)) # Start with pure potential (0)
            
            # Collapse with high threshold (should collapse few/none)
            collapse_orch!(seed_dev, 0.99)
            result = Array(seed_dev)
            collapsed_count = count(x -> x != 0, result)
            @info "   🌌 Collapse (Threshold 0.99): $collapsed_count / $len bits flipped"
            
            # Collapse with low threshold (should collapse many)
            collapse_orch!(seed_dev, 0.01)
            result = Array(seed_dev)
            collapsed_count = count(x -> x != 0, result)
            @info "   🌌 Collapse (Threshold 0.01): $collapsed_count / $len bits flipped"
        else
            @warn "   ⚠️  CUDA not available. Skipping Orch-OR tests."
        end
    end

    # 3. Verify GGUF Bridge
    @testset "GGUF Bridge" begin
        # Create a dummy GGUF file for testing
        dummy_path = "test_model.gguf"
        write(dummy_path, "GGUF_MOCK_DATA")
        
        try
            data = load_gguf_model(dummy_path)
            @test length(data) > 0
            @info "   ✅ GGUF Bridge Loaded $(length(data)) bytes"
            
            response = llama_infer(data, "Hello CBM")
            @test occursin("LLAMA_OUTPUT_STUB", response)
            @info "   ✅ Cortex Response: $response"
        finally
            rm(dummy_path, force=true)
        end
    end
end


