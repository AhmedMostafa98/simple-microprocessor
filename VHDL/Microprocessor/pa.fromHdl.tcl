
# PlanAhead Launch Script for Pre-Synthesis Floorplanning, created by Project Navigator

create_project -name Microprocessor -dir "C:/Users/Tefa/Desktop/final_design/Microprocessor/planAhead_run_2" -part xc6slx9tqg144-2
set_param project.pinAheadLayout yes
set srcset [get_property srcset [current_run -impl]]
set_property target_constrs_file "Microprocessor.ucf" [current_fileset -constrset]
set hdlfile [add_files [list {../../2ndterm/measurements project/aaaaaaaah/test/Adder/half_adder.vhd}]]
set_property file_type VHDL $hdlfile
set_property library work $hdlfile
set hdlfile [add_files [list {../../2ndterm/measurements project/aaaaaaaah/test/Adder/full_adder.vhd}]]
set_property file_type VHDL $hdlfile
set_property library work $hdlfile
set hdlfile [add_files [list {../../2ndterm/measurements project/aaaaaaaah/test/sign_extension/sign_extension.vhd}]]
set_property file_type VHDL $hdlfile
set_property library work $hdlfile
set hdlfile [add_files [list {../../2ndterm/measurements project/aaaaaaaah/test/ROM/ROM.vhd}]]
set_property file_type VHDL $hdlfile
set_property library work $hdlfile
set hdlfile [add_files [list {../../2ndterm/measurements project/aaaaaaaah/test/register_file/register_file.vhd}]]
set_property file_type VHDL $hdlfile
set_property library work $hdlfile
set hdlfile [add_files [list {../../2ndterm/measurements project/aaaaaaaah/test/RAM/RAM.vhd}]]
set_property file_type VHDL $hdlfile
set_property library work $hdlfile
set hdlfile [add_files [list {../../2ndterm/measurements project/aaaaaaaah/test/pc_register/pc_register.vhd}]]
set_property file_type VHDL $hdlfile
set_property library work $hdlfile
set hdlfile [add_files [list {../../2ndterm/measurements project/aaaaaaaah/test/Outport/Outport.vhd}]]
set_property file_type VHDL $hdlfile
set_property library work $hdlfile
set hdlfile [add_files [list {../../2ndterm/measurements project/aaaaaaaah/test/mux_4_1/mux_4_1.vhd}]]
set_property file_type VHDL $hdlfile
set_property library work $hdlfile
set hdlfile [add_files [list {../../2ndterm/measurements project/aaaaaaaah/test/mux_2_1/mux_2_1.vhd}]]
set_property file_type VHDL $hdlfile
set_property library work $hdlfile
set hdlfile [add_files [list {../../2ndterm/measurements project/aaaaaaaah/test/mux_21_3/mux_21_3.vhd}]]
set_property file_type VHDL $hdlfile
set_property library work $hdlfile
set hdlfile [add_files [list {../../2ndterm/measurements project/aaaaaaaah/test/input_port/input_port.vhd}]]
set_property file_type VHDL $hdlfile
set_property library work $hdlfile
set hdlfile [add_files [list {../../2ndterm/measurements project/aaaaaaaah/test/Control_unit/control_unit.vhd}]]
set_property file_type VHDL $hdlfile
set_property library work $hdlfile
set hdlfile [add_files [list {../../2ndterm/measurements project/aaaaaaaah/test/ALU/ALU.vhd}]]
set_property file_type VHDL $hdlfile
set_property library work $hdlfile
set hdlfile [add_files [list {../../2ndterm/measurements project/aaaaaaaah/test/Adder/Adder.vhd}]]
set_property file_type VHDL $hdlfile
set_property library work $hdlfile
set hdlfile [add_files [list {Microprocessor.vhd}]]
set_property file_type VHDL $hdlfile
set_property library work $hdlfile
set_property top Microprocessor $srcset
add_files [list {Microprocessor.ucf}] -fileset [get_property constrset [current_run]]
open_rtl_design -part xc6slx9tqg144-2
