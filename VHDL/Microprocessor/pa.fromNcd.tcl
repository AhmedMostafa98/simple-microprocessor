
# PlanAhead Launch Script for Post PAR Floorplanning, created by Project Navigator

create_project -name Microprocessor -dir "C:/Users/Tefa/Desktop/2ndterm/measurements project/aaaaaaaah/test/Microprocessor/planAhead_run_2" -part xc6slx9tqg144-2
set srcset [get_property srcset [current_run -impl]]
set_property design_mode GateLvl $srcset
set_property edif_top_file "C:/Users/Tefa/Desktop/2ndterm/measurements project/aaaaaaaah/test/Microprocessor/Microprocessor.ngc" [ get_property srcset [ current_run ] ]
add_files -norecurse { {C:/Users/Tefa/Desktop/2ndterm/measurements project/aaaaaaaah/test/Microprocessor} }
set_property target_constrs_file "Microprocessor.ucf" [current_fileset -constrset]
add_files [list {Microprocessor.ucf}] -fileset [get_property constrset [current_run]]
link_design
read_xdl -file "C:/Users/Tefa/Desktop/2ndterm/measurements project/aaaaaaaah/test/Microprocessor/Microprocessor.ncd"
if {[catch {read_twx -name results_1 -file "C:/Users/Tefa/Desktop/2ndterm/measurements project/aaaaaaaah/test/Microprocessor/Microprocessor.twx"} eInfo]} {
   puts "WARNING: there was a problem importing \"C:/Users/Tefa/Desktop/2ndterm/measurements project/aaaaaaaah/test/Microprocessor/Microprocessor.twx\": $eInfo"
}
