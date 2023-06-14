quietly set ACTELLIBNAME SmartFusion2
quietly set PROJECT_DIR "C:/Users/Nathan/Desktop/UADL/Internship/Acromax/NAND-Flash-Controller"

if {[file exists presynth/_info]} {
   echo "INFO: Simulation library presynth already exists"
} else {
   file delete -force presynth 
   vlib presynth
}
vmap presynth presynth
vmap SmartFusion2 "C:/Microsemi/Libero_SoC_v2022.1/Designer/lib/modelsimpro/precompiled/vlog/SmartFusion2"

vlog "+incdir+${PROJECT_DIR}/hdl" -vlog01compat -work presynth "${PROJECT_DIR}/hdl/nand.v"
vlog "+incdir+${PROJECT_DIR}/hdl" "+incdir+${PROJECT_DIR}/stimulus" -vlog01compat -work presynth "${PROJECT_DIR}/stimulus/controller_tb.v"

vsim -L SmartFusion2 -L presynth  -t 1fs presynth.controller_tb
add wave /controller_tb/*
run 1000ns
