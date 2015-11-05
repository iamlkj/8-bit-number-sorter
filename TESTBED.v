
`timescale 1ns/10ps
`include "sorter.v"
//`include "./Netlist/sorter_SYN.v"
`include "PATTERN.v"

module TESTBED;

//---------------------------------------------------------------------
// DUMP WAVEFORM
//---------------------------------------------------------------------

initial begin
  $fsdbDumpfile("sorter.fsdb");
  $fsdbDumpvars;
  //$sdf_annotate("./Netlist/sorter_SYN.sdf",top);
end

//---------------------------------------------------------------------
//WIRE AND REG DECLARATION
//---------------------------------------------------------------------
wire CLK;
wire RESET;

wire signed [7:0] IN1;
wire IN2;

wire signed [7:0] OUT1;
wire OUT2;


//---------------------------------------------------------------------
// MODULE INSTANTIATION
//---------------------------------------------------------------------

PATTERN PATTERN
(
  .RESET(RESET),
  .CLK(CLK),
  .in1(IN1),
  .in2(IN2),
  .mout1(OUT1),
  .mout2(OUT2)
);

sorter top
(
  .RESET(RESET),
  .CLK(CLK),
  .in(IN1),
  .in_valid(IN2),
  .out(OUT1),
  .out_valid(OUT2)
);

endmodule
