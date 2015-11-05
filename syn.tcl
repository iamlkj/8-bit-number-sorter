#======================================================
#
# Synopsys Synthesis Scripts (Design Vision dctcl mode)
#
#======================================================

#======================================================
#  Library Selecting and Setting
#======================================================
# Use the default library of .synopsys_dc.setup
# source Lib_T018.scr

set DESIGN "sorter"

#======================================================
#  Read RTL Code
#======================================================
#read_file -format verilog  TOP.v
#current_design TOP 
read_file -format verilog $DESIGN\.v
current_design $DESIGN
link

#======================================================
#  Global Setting
#======================================================
set_operating_conditions -min_library fast -min fast  -max_library slow -max slow
set_wire_load_model -name tsmc13_wl10 -library slow
set_wire_load_mode  top

#======================================================
#  Set Design Constraints
#======================================================
#set_max_delay    8    -from [all_inputs] -to [all_outputs]
#create_clock -period 8 -name "CLK"
create_clock -period 10 [get_ports CLK]

set_input_transition 0.2  [all_inputs]
set_input_delay  5 -clock CLK  [all_inputs]
set_output_delay 5 -clock CLK  [all_outputs]
set_load         0.5           [all_outputs]
set_dont_touch_network [get_clocks CLK]

check_design
#======================================================
#  Check Design
#======================================================
check_timing >  Report/check_timing.txt

#======================================================
#  Optimization
#======================================================
#--- add your optimization settings here --------------
uniquify
set_fix_multiple_port_nets -all -buffer_constants [get_designs *]
compile -map_effort high -area_effort high

check_design
check_timing
#======================================================
#  Output Reports 
#======================================================
report_design >  Report/design.txt
report_port >  Report/port.txt
report_net >  Report/net.txt
report_timing_requirements >  Report/timing_requirements.txt
report_constraint >  Report/constraint.txt
report_timing >  Report/timing.txt
report_area >  Report/area.txt
report_power > Report/power.txt

#======================================================
#  Change Naming Rule
#======================================================
remove_unconnected_ports -blast_buses [get_cells -hierarchical *]
set bus_inference_style {%s[%d]}
set bus_naming_style {%s[%d]}
set hdlout_internal_busses true
change_names -hierarchy -rule verilog
define_name_rules name_rule -allowed {a-z A-Z 0-9 _} -max_length 255 -type cell
define_name_rules name_rule -allowed {a-z A-Z 0-9 _[]} -max_length 255 -type net
define_name_rules name_rule -map {{"\\*cell\\*" "cell"}}
define_name_rules name_rule -case_insensitive
change_names -hierarchy -rules name_rule

#======================================================
#  Output Results
#======================================================
write -format verilog  -output  Netlist/$DESIGN\_SYN.v -hierarchy
write_sdf -version 1.0 -context verilog -load_delay net  Netlist/$DESIGN\_SYN.sdf
write_sdc  Netlist/$DESIGN\_SYN.sdc

#======================================================
#  Finish and Quit
#======================================================
exit
