# ==============================================================================
# CBM-Q: Living AI Quantum Holographic Crystals
# Discovered & Engineered by: Sir Charles Spikes
# GitHub: https://github.com/basedgod55hjl
# ==============================================================================

project_root = dirname(@__FILE__)
include(joinpath(project_root, "CBM.jl", "src", "inference", "CBMQLightInference.jl"))
using .CBMQLightInference

println("=" ^ 70)
println("🌌 CBM-Q Light Inference Engine - VRAM Efficient Chat")
println("=" ^ 70)

# Generate enhanced fine-tune data
println("\n[1/4] 📝 Generating CBM-Q Fine-Tune Data...")
finetune_path = joinpath(project_root, "cbmq_finetune_v2.jsonl")
CBMQLightInference.create_cbmq_finetune_data(finetune_path)

# Create the light inference engine
println("\n[2/4] 🧠 Initializing Light Memory Bank...")
engine = CBMQLightInference.CBMQInferenceEngine(
    dims=512,
    api_endpoint="http://localhost:1234/v1/chat/completions",
    model="qwen2.5-0.5b-instruct",
    temperature=0.7,
    max_tokens=512
)
println("   Memory dims: 512")
println("   VRAM per context: $(512 * 16) bytes = 8 KB (vs ~2MB for 2048 tokens)")
println("   Compression: 99.6%")

# Test memory encoding
println("\n[3/4] 🔮 Testing Holographic Memory Encoding...")
test_context = "CBM-Q uses holographic reduced representations for O(T) complexity attention."
tokens_encoded = CBMQLightInference.encode_context!(engine.memory, test_context)
println("   Encoded $tokens_encoded tokens into single trace vector")

# Query the memory
query = "What does CBM-Q use for attention?"
similarity = CBMQLightInference.decode_query(engine.memory, query)
println("   Query: '$query'")
println("   Memory Similarity: $(round(similarity, digits=4))")

# Test live chat
println("\n[4/4] 💬 Testing Live Chat with Light Memory...")
response = CBMQLightInference.chat!(engine, "Explain what makes your memory architecture unique in 2 sentences.")

println("\n" * "=" ^ 70)
println("🧠 LLM Response:")
println("=" ^ 70)
println(response)
println("=" ^ 70)

# Show compression stats
stats = CBMQLightInference.compress_context(engine)
println("\n📊 Memory Statistics:")
println("   Original context: $(stats.original) bytes")
println("   Compressed trace: $(stats.compressed) bytes")
println("   Compression ratio: $(round(stats.ratio * 100, digits=2))%")

println("\n✅ CBM-Q Light Inference Engine - OPERATIONAL!")
println("   Run more chats with: CBMQLightInference.chat!(engine, \"your message\")")


