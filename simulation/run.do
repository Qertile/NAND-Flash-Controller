quietly set ACTELLIBNAME SmartFusion2
quietly set PROJECT_DIR "C:/Users/Nathan/Desktop/UADL/Internship/Acromax/NAND-Flash-Controller/Project"

if {[file exists presynth/_info]} {
   echo "INFO: Simulation library presynth already exists"
} else {
   file delete -force presynth 
   vlib presynth
}
vmap presynth presynth
vmap SmartFusion2 "C:/Microsemi/Libero_SoC_v2022.1/Designer/lib/modelsimpro/precompiled/vlog/SmartFusion2"
if {[file exists COREAPB3_LIB/_info]} {
   echo "INFO: Simulation library COREAPB3_LIB already exists"
} else {
   file delete -force COREAPB3_LIB 
   vlib COREAPB3_LIB
}
vmap COREAPB3_LIB "COREAPB3_LIB"

vlog "+incdir+${PROJECT_DIR}/hdl" -vlog01compat -work presynth "${PROJECT_DIR}/hdl/FSM.v"
vlog "+incdir+${PROJECT_DIR}/hdl" "+incdir+${PROJECT_DIR}/stimulus" -vlog01compat -work presynth "${PROJECT_DIR}/stimulus/FSM_tb.v"

vsim -L SmartFusion2 -L presynth -L COREAPB3_LIB  -t 1fs presynth.FSM_tb
add wave /FSM_tb/*
run 1000ns
