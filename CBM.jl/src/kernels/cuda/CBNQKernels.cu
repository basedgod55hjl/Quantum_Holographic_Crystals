#ifndef CBN_OPCODES_CUH
#define CBN_OPCODES_CUH

#include <cuda.h>
#include <stdint.h>
#include "flux_core.cuh" // Reuse our Hyperbolic definitions

// --- Opcode Definitions (0x01 - 0x23) ---
#define OP_XOR      0x01
#define OP_AND      0x02
#define OP_OR       0x03
#define OP_NOT      0x04
#define OP_ROTL     0x05
#define OP_ROTR     0x06
#define OP_ADD      0x07
#define OP_SUB      0x08
#define OP_MUL      0x09
// Graph & Routing
#define OP_ROUTE    0x10
#define OP_MERGE    0x11
// Orch-OR Collapse
#define OP_ENTROPY  0x20
#define OP_COLLAPSE 0x21

__device__ uint64_t rotate_left(uint64_t val, int n) {
    return (val << n) | (val >> (64 - n));
}

__device__ uint64_t rotate_right(uint64_t val, int n) {
    return (val >> n) | (val << (64 - n));
}

// 🌀 The Core Binary Opcode Kernel
// Executes the deterministic logic graph
extern "C" __global__ void cbn_op_kernel(uint64_t* a, uint64_t* b, uint64_t* out, uint8_t opcode, int length) {
    int idx = blockIdx.x * blockDim.x + threadIdx.x;
    if (idx >= length) return;

    // Load inputs once
    uint64_t val_a = a[idx];
    uint64_t val_b = b[idx];
    uint64_t result = 0;

    switch(opcode) {
        // Logic
        case OP_XOR: result = val_a ^ val_b; break;
        case OP_AND: result = val_a & val_b; break;
        case OP_OR:  result = val_a | val_b; break;
        case OP_NOT: result = ~val_a; break;
        
        // Bit Manipulation
        case OP_ROTL: result = rotate_left(val_a, (int)(val_b % 64)); break;
        case OP_ROTR: result = rotate_right(val_a, (int)(val_b % 64)); break;
        
        // Arithmetic (Hyperbolic-aware in full version, standard here for reference)
        case OP_ADD:  result = val_a + val_b; break;
        case OP_SUB:  result = val_a - val_b; break;
        case OP_MUL:  result = val_a * val_b; break;
        
        // Default pass-through
        default: result = val_a; break;
    }
    
    out[idx] = result;
}

// 🌌 Orch-OR Collapse Kernel
// This introduces the "Observational" step where the wave function collapses
// based on a threshold and quantum seed entropy.
extern "C" __global__ void orch_or_collapse_kernel(uint64_t* state, int length, double threshold, uint64_t seed_entropy) {
    int idx = blockIdx.x * blockDim.x + threadIdx.x;
    if (idx >= length) return;

    // Simple deterministic pseudo-random collapse function
    // In production, this would sample from the QuantumSeed buffer
    uint64_t current = state[idx];
    
    // Hash function for local entropy
    uint64_t h = current ^ seed_entropy;
    h ^= (h << 13);
    h ^= (h >> 7);
    h ^= (h << 17);
    
    // Normalize to 0.0 - 1.0
    double probability = (double)(h % 1000000) / 1000000.0;
    
    // The Collapse: IF probability > threshold -> 1 (Bit Flip/Collapse) ELSE -> 0 (Maintain)
    // We modify the state in place to "Resolution"
    if (probability > threshold) {
        state[idx] = ~current; // Invert/Collapse
    }
    // Else: state remains coherent (unchanged)
}

#endif // CBN_OPCODES_CUH
