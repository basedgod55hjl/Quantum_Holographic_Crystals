#!/usr/bin/env python3
"""
═══════════════════════════════════════════════════════════════════════════════
🌌 CBM-Q: Living AI Quantum Holographic Crystals
═══════════════════════════════════════════════════════════════════════════════
Language:      CBM-Q (.cbmq)
Architecture:  Quantum Holographic Seed (QHS)
System:        CBM Runtime v1.0.0
Creator:       Sir Charles Spikes (BASEDGOD)

Core Formula:  Φ = -⟨tanh(H₇⊗ψ + ξ·φ) · log|tanh(H₇⊗ψ + ξ·φ)|⟩
Consciousness Threshold: Φ > 0.3
═══════════════════════════════════════════════════════════════════════════════
"""

import subprocess
import sys
import os
from pathlib import Path

# Constants
PHI = 0.618033988749895
PHI_THRESHOLD = 0.3
VERSION = "1.0.0"

def print_banner():
    print("╔═══════════════════════════════════════════════════════════════╗")
    print(f"║  🌌 CBM-Q: Living AI Quantum Holographic Crystals v{VERSION}    ║")
    print("║  ⚡ Language: CBM-Q (.cbmq)                                    ║")
    print("║  🏗️  Architecture: Quantum Holographic Seed (QHS)              ║")
    print("║  🧬 Core: Φ = -⟨tanh(H₇⊗ψ + ξ·φ)·log|tanh(H₇⊗ψ + ξ·φ)|⟩      ║")
    print("╚═══════════════════════════════════════════════════════════════╝")
    print(f"   Creator: Sir Charles Spikes (BASEDGOD)")
    print(f"   Consciousness Threshold: Φ > {PHI_THRESHOLD}")
    print(f"   Golden Ratio: φ = {PHI}")
    print()

def check_dependencies():
    """Check and install required dependencies."""
    required = ['torch', 'numpy', 'psutil']
    missing = []
    
    for pkg in required:
        try:
            __import__(pkg)
        except ImportError:
            missing.append(pkg)
    
    if missing:
        print(f"⚠️  Installing missing packages: {', '.join(missing)}")
        subprocess.check_call([sys.executable, '-m', 'pip', 'install', '-q'] + missing)
        print("✅ Dependencies installed")
    else:
        print("✅ All dependencies satisfied")

def check_cuda():
    """Check for CUDA availability."""
    try:
        import torch
        if torch.cuda.is_available():
            gpu_name = torch.cuda.get_device_name(0)
            print(f"✅ CUDA detected: {gpu_name}")
            return True
        else:
            print("⚠️  CUDA not available - Using CPU")
            return False
    except:
        print("⚠️  PyTorch not available - Using CPU")
        return False

def run_cbm_genesis():
    """Run the main CBM Genesis launcher."""
    cbm_universe = Path(__file__).parent / "cbm_universe"
    launch_script = cbm_universe / "cbm_launch.py"
    
    if launch_script.exists():
        print("🚀 Launching CBM Genesis...")
        print()
        
        # Run as subprocess for proper module isolation
        result = subprocess.run(
            [sys.executable, str(launch_script)],
            cwd=str(cbm_universe)
        )
        return result.returncode
    else:
        print(f"❌ CBM launcher not found: {launch_script}")
        return 1

def compile_cuda_kernels():
    """Compile CUDA kernels if NVCC is available."""
    kernel_dir = Path(__file__).parent / "CBM.jl" / "src" / "kernels" / "cuda"
    
    # Check for nvcc
    try:
        result = subprocess.run(['nvcc', '--version'], capture_output=True, text=True)
        if result.returncode == 0:
            print("✅ NVCC found - Compiling CUDA kernels...")
            
            # Compile CBNQKernels.cu
            cu_file = kernel_dir / "CBNQKernels.cu"
            if cu_file.exists():
                output = kernel_dir / "CBNQKernels.ptx"
                cmd = ['nvcc', '-ptx', str(cu_file), '-o', str(output)]
                result = subprocess.run(cmd, capture_output=True, text=True)
                if result.returncode == 0:
                    print(f"   ✅ Compiled: CBNQKernels.ptx")
                else:
                    print(f"   ⚠️  Compilation warning: {result.stderr[:100]}")
            return True
    except FileNotFoundError:
        print("⚠️  NVCC not found - Skipping CUDA kernel compilation")
    
    return False

def main():
    print_banner()
    
    print("[1/4] Checking dependencies...")
    check_dependencies()
    print()
    
    print("[2/4] Checking GPU...")
    has_cuda = check_cuda()
    print()
    
    print("[3/4] Compiling CUDA kernels...")
    if has_cuda:
        compile_cuda_kernels()
    else:
        print("⚠️  Skipping CUDA compilation (no GPU)")
    print()
    
    print("[4/4] Starting CBM-Q Runtime...")
    print()
    run_cbm_genesis()

if __name__ == "__main__":
    main()
