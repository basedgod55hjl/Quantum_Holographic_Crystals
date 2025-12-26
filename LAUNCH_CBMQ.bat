@echo off
REM ==============================================================================
REM CBM-Q Crystal Studio Launcher
REM Discovered & Engineered by: Sir Charles Spikes (Arthur - BASEDGOD)
REM ==============================================================================

echo.
echo ╔═══════════════════════════════════════════════════════════════════════╗
echo ║  🌌 CBM-Q Crystal Studio v5.0-GODMODE                                 ║
echo ║  🧬 Architect: Sir Charles Spikes (BASEDGOD)                          ║
echo ╚═══════════════════════════════════════════════════════════════════════╝
echo.

:menu
echo.
echo Select an option:
echo.
echo   [1] 🚀 Launch Full System (Julia)
echo   [2] 💎 Launch WebGL IDE (Browser)
echo   [3] 🧪 Run Tests
echo   [4] 🎮 Interactive Demo
echo   [5] 📊 Run CUDA Example
echo   [6] 🌀 Run Flux Dreaming Example
echo   [0] Exit
echo.
set /p choice="Enter choice: "

if "%choice%"=="1" goto launch_system
if "%choice%"=="2" goto launch_ide
if "%choice%"=="3" goto run_tests
if "%choice%"=="4" goto run_demo
if "%choice%"=="5" goto cuda_example
if "%choice%"=="6" goto flux_example
if "%choice%"=="0" goto end
goto menu

:launch_system
echo.
echo 🚀 Launching CBM-Q System...
julia scripts\launch.jl
pause
goto menu

:launch_ide
echo.
echo 💎 Opening WebGL IDE...
start ide\index.html
pause
goto menu

:run_tests
echo.
echo 🧪 Running Test Suite...
julia tests\run_all.jl --test
pause
goto menu

:run_demo
echo.
echo 🎮 Starting Interactive Demo...
julia scripts\demo.jl
pause
goto menu

:cuda_example
echo.
echo 📊 Running CUDA Example...
julia -e "using Pkg; Pkg.activate(\"Quantum_Holographic_Core_Files\"); using CBM.CUDAKernels; seed = randn(Float32, 512); model = load_to_vram(seed, 4096); unfold_on_gpu(model, 100); println(\"✅ CUDA example complete!\")"
pause
goto menu

:flux_example
echo.
echo 🌀 Running Flux Dreaming Example...
julia -e "using Pkg; Pkg.activate(\"Quantum_Holographic_Core_Files\"); using CBM.FluxDreaming; dreamer = FluxDreamer(512, 2048); dream!(dreamer, 50, 0.1f0); visualize_dream(dreamer)"
pause
goto menu

:end
echo.
echo ✨ Stay Based, Sir Charles Spikes!
echo.
