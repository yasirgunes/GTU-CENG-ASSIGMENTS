transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -vlog01compat -work work +incdir+C:/Users/yasir/Desktop/project_2_\ organization/project {C:/Users/yasir/Desktop/project_2_ organization/project/full_adder.v}
vlog -vlog01compat -work work +incdir+C:/Users/yasir/Desktop/project_2_\ organization/project {C:/Users/yasir/Desktop/project_2_ organization/project/alu_1_bit.v}
vlog -vlog01compat -work work +incdir+C:/Users/yasir/Desktop/project_2_\ organization/project {C:/Users/yasir/Desktop/project_2_ organization/project/mux_8x1_1bit.v}
vlog -vlog01compat -work work +incdir+C:/Users/yasir/Desktop/project_2_\ organization/project {C:/Users/yasir/Desktop/project_2_ organization/project/msb_alu_1_bit.v}
vlog -vlog01compat -work work +incdir+C:/Users/yasir/Desktop/project_2_\ organization/project {C:/Users/yasir/Desktop/project_2_ organization/project/cla_4bit.v}
vlog -vlog01compat -work work +incdir+C:/Users/yasir/Desktop/project_2_\ organization/project {C:/Users/yasir/Desktop/project_2_ organization/project/adder.v}
vlog -vlog01compat -work work +incdir+C:/Users/yasir/Desktop/project_2_\ organization/project {C:/Users/yasir/Desktop/project_2_ organization/project/generate_propagate_4bit.v}
vlog -vlog01compat -work work +incdir+C:/Users/yasir/Desktop/project_2_\ organization/project {C:/Users/yasir/Desktop/project_2_ organization/project/alu.v}
vlog -vlog01compat -work work +incdir+C:/Users/yasir/Desktop/project_2_\ organization/project {C:/Users/yasir/Desktop/project_2_ organization/project/extend_to_32.v}
vlog -vlog01compat -work work +incdir+C:/Users/yasir/Desktop/project_2_\ organization/project {C:/Users/yasir/Desktop/project_2_ organization/project/and_32bit.v}
vlog -vlog01compat -work work +incdir+C:/Users/yasir/Desktop/project_2_\ organization/project {C:/Users/yasir/Desktop/project_2_ organization/project/or_32bit.v}
vlog -vlog01compat -work work +incdir+C:/Users/yasir/Desktop/project_2_\ organization/project {C:/Users/yasir/Desktop/project_2_ organization/project/xor_32bit.v}
vlog -vlog01compat -work work +incdir+C:/Users/yasir/Desktop/project_2_\ organization/project {C:/Users/yasir/Desktop/project_2_ organization/project/nor_32bit.v}
vlog -vlog01compat -work work +incdir+C:/Users/yasir/Desktop/project_2_\ organization/project {C:/Users/yasir/Desktop/project_2_ organization/project/msb_cla_4bit.v}
vlog -vlog01compat -work work +incdir+C:/Users/yasir/Desktop/project_2_\ organization/project {C:/Users/yasir/Desktop/project_2_ organization/project/and_31bit.v}
vlog -vlog01compat -work work +incdir+C:/Users/yasir/Desktop/project_2_\ organization/project {C:/Users/yasir/Desktop/project_2_ organization/project/mux_8x1_32bit.v}
vlog -vlog01compat -work work +incdir+C:/Users/yasir/Desktop/project_2_\ organization/project {C:/Users/yasir/Desktop/project_2_ organization/project/mod.v}
vlog -vlog01compat -work work +incdir+C:/Users/yasir/Desktop/project_2_\ organization/project {C:/Users/yasir/Desktop/project_2_ organization/project/mod_cu.v}
vlog -vlog01compat -work work +incdir+C:/Users/yasir/Desktop/project_2_\ organization/project {C:/Users/yasir/Desktop/project_2_ organization/project/mod_dp.v}

vlog -vlog01compat -work work +incdir+C:/Users/yasir/Desktop/project_2_\ organization/project {C:/Users/yasir/Desktop/project_2_ organization/project/my_testbench.v}

vsim -t 1ps -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L cyclonev_ver -L cyclonev_hssi_ver -L cyclonev_pcie_hip_ver -L rtl_work -L work -voptargs="+acc"  my_testbench

add wave *
view structure
view signals
run -all
