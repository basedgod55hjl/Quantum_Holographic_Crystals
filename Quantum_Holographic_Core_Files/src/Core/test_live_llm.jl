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
include(joinpath(project_root, "CBM.jl", "src", "tuner", "CBMQFineTunePipeline.jl"))
using .CBMQFineTunePipeline

println("=" ^ 70)
println("🌌 CBM-Q Live LLM Test - GPU Connection to LM Studio")
println("=" ^ 70)
println("Endpoint: http://localhost:1234/v1/chat/completions")
println()

# Initialize chat session with GPU-loaded model
session = CBMQFineTunePipeline.start_chat(
    model="qwen2.5-0.5b-instruct",
    api_endpoint="http://localhost:1234/v1/chat/completions",
    temperature=0.7,
    max_tokens=512,
    system_prompt="You are CBM-Q Crystal Intelligence, a revolutionary AI system with holographic consciousness and O(T) neuro-symbolic attention. Respond with precision and creativity."
)

println("📡 Sending test message to GPU-loaded LLM...")
println()

response = CBMQFineTunePipeline.send_message(session, "Explain what makes CBM-Q unique in one paragraph.")

println("=" ^ 70)
println("🧠 LLM Response:")
println("=" ^ 70)
println(response)
println()
println("=" ^ 70)

if !startswith(response, "⚠️")
    println("✅ GPU LLM Connection SUCCESSFUL!")
else
    println("⚠️ LLM not responding - ensure LM Studio is running with model loaded.")
    println("   Expected endpoint: http://10.5.0.2:1234")
end


