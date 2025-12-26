# ==============================================================================
# CBM-Q: Living AI Quantum Holographic Crystals
# Discovered & Engineered by: Sir Charles Spikes
# ==============================================================================

# CBN-Q .julia File Format (Version 1.0)

======================================

LOCKED SPECIFICATION - DO NOT MODIFY WITHOUT CONSENSUS
 ------------------------------------------------------

This document defines the binary serialization format for CBN-Q (Conscious Binary Network - Quantum) models, loadable by the CBM-Julia-Genesis orchestration system.

## 1. Header (16 bytes)

| Offset | Field | Type | Description |
|---|---|---|---|
| 0x00 | Magic | 4 bytes | Literal `CBNQ` (0x43 0x42 0x4E 0x51) |
| 0x04 | Version | 2 bytes | 0x0100 (Major 1, Minor 0) |
| 0x06 | Flags | 2 bytes | Bit 0: CUDA Optimized<br>Bit 1: Compressed (LZ4)<br>Bit 2: Encrypted |
| 0x08 | Reserved| 8 bytes | Future use (Padding to 16 bytes) |

## 2. Section 1: Metadata

| Field | Type | Description |
|---|---|---|
| Model Name | 64 bytes | UTF-8 string, null-padded |
| Architecture | 32 bytes | UTF-8 string, null-padded (e.g., "7D-Hyperbolic-Lattice") |
| Seed Size | UInt32 | Size of the Quantum Seed in bytes |
| Graph Node Count | UInt32 | Number of computational nodes in the graph |

## 3. Section 2: Graph Nodes

Serialized immediately after Metadata.
Each node is **13 bytes** (packed):

`[opcode: UInt8][input_a: UInt32][input_b: UInt32][flags: UInt32]`

* **Opcode**: Operation identifier (see `cbn_opcodes.cuh`)
* **Input A**: Index of first input node / register
* **Input B**: Index of second input node / register
* **Flags**: Routing and control bits (e.g., collapse threshold met)

## 4. Section 3: Seeds (BQS)

Packed array of `UInt64` values.

* **Length**: Defined by `Seed Size` in Metadata.
* **Content**: Raw entropy gathered from Quantum Random Sources or Transmuted Weights.

## 5. Section 4: GGUF Bridge References (Optional)

Variable length section.

* **Count**: UInt32 (Number of external references)
* **Entries**:
  * **Hash**: 32 bytes (SHA-256 of the target GGUF file)
  * **Path Length**: UInt16
  * **Path**: UTF-8 String (Relative or Absolute path to .gguf model)

✅ **Deterministic Layout**: The file must be chemically deterministic. The same seed + same graph = same .julia file byte-for-byte.


