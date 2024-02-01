transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -vlog01compat -work work +incdir+C:/Users/yasir/Desktop/homeworks/computer\ organization/organization\ project\ 3 {C:/Users/yasir/Desktop/homeworks/computer organization/organization project 3/xor_32bit.v}
vlog -vlog01compat -work work +incdir+C:/Users/yasir/Desktop/homeworks/computer\ organization/organization\ project\ 3 {C:/Users/yasir/Desktop/homeworks/computer organization/organization project 3/or_32bit.v}
vlog -vlog01compat -work work +incdir+C:/Users/yasir/Desktop/homeworks/computer\ organization/organization\ project\ 3 {C:/Users/yasir/Desktop/homeworks/computer organization/organization project 3/mux_8x1_32bit.v}
vlog -vlog01compat -work work +incdir+C:/Users/yasir/Desktop/homeworks/computer\ organization/organization\ project\ 3 {C:/Users/yasir/Desktop/homeworks/computer organization/organization project 3/mux_8x1_1bit.v}
vlog -vlog01compat -work work +incdir+C:/Users/yasir/Desktop/homeworks/computer\ organization/organization\ project\ 3 {C:/Users/yasir/Desktop/homeworks/computer organization/organization project 3/msb_cla_4bit.v}
vlog -vlog01compat -work work +incdir+C:/Users/yasir/Desktop/homeworks/computer\ organization/organization\ project\ 3 {C:/Users/yasir/Desktop/homeworks/computer organization/organization project 3/msb_alu_1_bit.v}
vlog -vlog01compat -work work +incdir+C:/Users/yasir/Desktop/homeworks/computer\ organization/organization\ project\ 3 {C:/Users/yasir/Desktop/homeworks/computer organization/organization project 3/generate_propagate_4bit.v}
vlog -vlog01compat -work work +incdir+C:/Users/yasir/Desktop/homeworks/computer\ organization/organization\ project\ 3 {C:/Users/yasir/Desktop/homeworks/computer organization/organization project 3/full_adder.v}
vlog -vlog01compat -work work +incdir+C:/Users/yasir/Desktop/homeworks/computer\ organization/organization\ project\ 3 {C:/Users/yasir/Desktop/homeworks/computer organization/organization project 3/extend_to_32.v}
vlog -vlog01compat -work work +incdir+C:/Users/yasir/Desktop/homeworks/computer\ organization/organization\ project\ 3 {C:/Users/yasir/Desktop/homeworks/computer organization/organization project 3/cla_4bit.v}
vlog -vlog01compat -work work +incdir+C:/Users/yasir/Desktop/homeworks/computer\ organization/organization\ project\ 3 {C:/Users/yasir/Desktop/homeworks/computer organization/organization project 3/and_32bit.v}
vlog -vlog01compat -work work +incdir+C:/Users/yasir/Desktop/homeworks/computer\ organization/organization\ project\ 3 {C:/Users/yasir/Desktop/homeworks/computer organization/organization project 3/and_31bit.v}
vlog -vlog01compat -work work +incdir+C:/Users/yasir/Desktop/homeworks/computer\ organization/organization\ project\ 3 {C:/Users/yasir/Desktop/homeworks/computer organization/organization project 3/alu_1_bit.v}
vlog -vlog01compat -work work +incdir+C:/Users/yasir/Desktop/homeworks/computer\ organization/organization\ project\ 3 {C:/Users/yasir/Desktop/homeworks/computer organization/organization project 3/adder.v}
vlog -vlog01compat -work work +incdir+C:/Users/yasir/Desktop/homeworks/computer\ organization/organization\ project\ 3 {C:/Users/yasir/Desktop/homeworks/computer organization/organization project 3/mips.v}
vlog -vlog01compat -work work +incdir+C:/Users/yasir/Desktop/homeworks/computer\ organization/organization\ project\ 3 {C:/Users/yasir/Desktop/homeworks/computer organization/organization project 3/control_unit.v}
vlog -vlog01compat -work work +incdir+C:/Users/yasir/Desktop/homeworks/computer\ organization/organization\ project\ 3 {C:/Users/yasir/Desktop/homeworks/computer organization/organization project 3/alu.v}
vlog -vlog01compat -work work +incdir+C:/Users/yasir/Desktop/homeworks/computer\ organization/organization\ project\ 3 {C:/Users/yasir/Desktop/homeworks/computer organization/organization project 3/alu_control.v}
vlog -vlog01compat -work work +incdir+C:/Users/yasir/Desktop/homeworks/computer\ organization/organization\ project\ 3 {C:/Users/yasir/Desktop/homeworks/computer organization/organization project 3/sign_extend.v}
vlog -vlog01compat -work work +incdir+C:/Users/yasir/Desktop/homeworks/computer\ organization/organization\ project\ 3 {C:/Users/yasir/Desktop/homeworks/computer organization/organization project 3/mux_2x1_5bit.v}
vlog -vlog01compat -work work +incdir+C:/Users/yasir/Desktop/homeworks/computer\ organization/organization\ project\ 3 {C:/Users/yasir/Desktop/homeworks/computer organization/organization project 3/mux_2x1_32bit.v}
vlog -vlog01compat -work work +incdir+C:/Users/yasir/Desktop/homeworks/computer\ organization/organization\ project\ 3 {C:/Users/yasir/Desktop/homeworks/computer organization/organization project 3/register_block.v}
vlog -vlog01compat -work work +incdir+C:/Users/yasir/Desktop/homeworks/computer\ organization/organization\ project\ 3 {C:/Users/yasir/Desktop/homeworks/computer organization/organization project 3/instruction_block.v}
vlog -vlog01compat -work work +incdir+C:/Users/yasir/Desktop/homeworks/computer\ organization/organization\ project\ 3 {C:/Users/yasir/Desktop/homeworks/computer organization/organization project 3/memory_block.v}

vlog -vlog01compat -work work +incdir+C:/Users/yasir/Desktop/homeworks/computer\ organization/organization\ project\ 3 {C:/Users/yasir/Desktop/homeworks/computer organization/organization project 3/testbench.v}

vsim -t 1ps -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L cyclonev_ver -L cyclonev_hssi_ver -L cyclonev_pcie_hip_ver -L rtl_work -L work -voptargs="+acc"  testbench

add wave *
view structure
view signals
run -all
