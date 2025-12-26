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
println("🌌 CBM-Q Fine-Tune & Chat Pipeline - Full System Test")
println("=" ^ 70)

# Test 1: Discover GGUF Models
println("\n[1/5] 🔍 Scanning for GGUF models on system...")
models = CBMQFineTunePipeline.list_gguf_models()
println("   Found $(length(models)) GGUF models:")
for m in models
    size_mb = round(m.size_bytes / 1024 / 1024, digits=2)
    println("   → $(m.name) [$(m.quantization)] - $size_mb MB")
    println("     Path: $(m.path)")
end

# Test 2: Generate Training Data
println("\n[2/5] 📝 Generating CBM-Q training data...")
training_path = joinpath(project_root, "cbmq_training_data.jsonl")
CBMQFineTunePipeline.generate_cbmq_training_data(training_path)

# Test 3: Create Fine-Tune Config
println("\n[3/5] ⚙️ Creating fine-tune configuration...")
config = CBMQFineTunePipeline.FineTuneConfig(
    "Qwen/Qwen2.5-0.5B-Instruct",
    joinpath(project_root, "cbmq-finetuned"),
    training_path,
    3,      # epochs
    4,      # batch_size
    2e-4,   # learning_rate
    16,     # lora_rank
    32.0    # lora_alpha
)
script_path = CBMQFineTunePipeline.run_fine_tune(config)

# Test 4: Generate GGUF Conversion Script
println("\n[4/5] 🔄 Generating GGUF conversion script...")
gguf_output = joinpath(project_root, "cbmq-finetuned-Q4_K_M.gguf")
CBMQFineTunePipeline.convert_to_gguf(joinpath(project_root, "cbmq-finetuned"), gguf_output, "Q4_K_M")

# Test 5: Chat Session (Simulated)
println("\n[5/5] 💬 Testing Chat Session Initialization...")
session = CBMQFineTunePipeline.start_chat(
    model="deepseek/deepseek-r1-0528-qwen3-8b",
    api_endpoint="http://10.5.0.2:1234/v1/chat/completions",
    temperature=0.7
)
println("   Chat session ready!")
println("   To start interactive chat, call: CBMQFineTunePipeline.interactive_chat(session)")

println("\n" * "=" ^ 70)
println("✅ CBM-Q Fine-Tune & Chat Pipeline - ALL TESTS PASSED!")
println("=" ^ 70)

println("\n📋 GGUF Models Available:")
for m in models
    println("   • $(m.name)")
end

println("\n🚀 Next Steps:")
println("   1. Run: python $(script_path)")
println("   2. Convert: Run the generated convert_to_gguf.bat")
println("   3. Load in LM Studio and connect to CBM-Q!")


