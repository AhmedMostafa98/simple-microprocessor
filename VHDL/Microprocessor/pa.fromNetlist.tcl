
# PlanAhead Launch Script for Post-Synthesis pin planning, created by Project Navigator

create_project -name Microprocessor -dir "C:/Users/Tefa/Desktop/final_design/Microprocessor/planAhead_run_3" -part xc6slx9csg324-2
set_property design_mode GateLvl [get_property srcset [current_run -impl]]
set_property edif_top_file "C:/Users/Tefa/Desktop/final_design/Microprocessor/Microprocessor.ngc" [ get_property srcset [ current_run ] ]
add_files -norecurse { {C:/Users/Tefa/Desktop/final_design/Microprocessor} }
set_param project.pinAheadLayout  yes
set_property target_constrs_file "Microprocessor.ucf" [current_fileset -constrset]
add_files [list {Microprocessor.ucf}] -fileset [get_property constrset [current_run]]
link_design
