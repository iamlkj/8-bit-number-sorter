
module PATTERN(RESET,CLK,in1,in2,mout1,mout2);

//---------------------------------------------------------------------
// INPUT AND OUTPUT DECLARATION
//---------------------------------------------------------------------

  output CLK;
  output RESET;
  output signed [7:0] in1;
  output in2;

  input signed [7:0] mout1;
  input mout2;

//---------------------------------------------------------------------
// WIRE AND REG DECLARATION
//---------------------------------------------------------------------

  parameter CYCLE = 10;
  parameter SIZE = 8;
  parameter NUM = 20;
  parameter TOTAL = SIZE*NUM;	// the number of execute
  integer i,j,k,e,times,times2;
 
  reg CLK;
  reg RESET;      
  reg signed [7:0] in1;
  reg in2;

  wire signed [7:0] mout1;
  wire mout2;
  
  reg [7:0] mem1[0:TOTAL-1];
  reg [7:0] mem2[0:TOTAL-1];
  reg delay;
  
  

//---------------------------------------------------------------------
// CLOCK GENERATION
//---------------------------------------------------------------------

  always #(5)    CLK = ~ CLK;
  
//---------------------------------------------------------------------
// TEST PATTERN
//---------------------------------------------------------------------

initial
    begin
      CLK = 0;
      RESET = 0;
      delay = 0;
	  times = 1;
	  times2 = 1;
      i=0;j=0;k=0;e=0;
      $readmemh("IN.txt",mem1);
      $readmemh("OUT.txt",mem2);
      @(negedge CLK) RESET <= 1;
      for(i=0;i<NUM;i=i+1)
	  begin
			for(j=0;j<SIZE;j=j+1)
			begin
				@(negedge CLK)
				RESET <= 0;
				in1<=mem1[i*SIZE+j];
				in2<=1'b1;
			end
			begin
				@(negedge CLK)
				in1<=8'd0;
				in2<=1'b0;
			end
			times = 1;
			times2 = 1;
			while(times<=8)
			begin
				@(negedge CLK)
				if(mout2)
				begin
					$display( "OUT:%x  ANS:%x",mout1,mem2[k]);
					if (mout1!==mem2[k])
					begin
						$display( "Different in K:%d ",k);
						$display( "!!!!!!!!!!!!!!!!!!!!!!!!!!");
						$finish;
					end
					k=k+1;
					times=times+1;
				end
				else
				begin
					if(times2>10)
					begin
						$display( "latency reach!!!");
						$finish;
					end
					times2=times2+1;
				end
			end
	  end
	  $display("Good!just do it!!\n" );
      $finish;
end

endmodule	
