module sorter(CLK, RESET, in, in_valid, out, out_valid);
input signed [7:0] in;
input in_valid, CLK, RESET;
output signed [7:0] out;
output out_valid;
reg ;
reg signed[7:0]out;
reg print,out_valid;
reg signed[7:0]c0,c1,c2,c3,c4,c5,c6,c7;
reg[3:0]c;
always @(posedge CLK)
begin
	if(RESET)
	begin
		c=0;
		print=0;
		out_valid=0
		out=0;
		c0=0;
		c1=0;
		c2=0;
		c3=0;
		c4=0;
		c5=0;
		c6=0;
		c7=0;
	end
	else if(print)
	begin
		out_valid=1;
		case(c)
		0:out=c0;
		1:out=c1;
		2:out=c2;
		3:out=c3;
		4:out=c4;
		5:out=c5;
		6:out=c6;
		7:out=c7;
		8:
		begin
			c=0;
			print=0;
			out_valid=0
			out=0;
			c0=0;
			c1=0;
			c2=0;
			c3=0;
			c4=0;
			c5=0;
			c6=0;
			c7=0;
		end
		default: out=0;
		endcase
		c=c+1;
	end

	else if(in_valid)
	begin
		case(c)
		0:c0<=in;
		1:
		begin
			else if(in>=c0)
			begin
				c1<=in;
			end
			else
			begin
				c1<=c0;
				c0<=in;
			end
		end
		2:
		begin
			if(in>=c1)
			begin

				c2<=in;
			end
			else if(in>=c0)
			begin

				c2<=c1;
				c1<=in;
			end
			else
			begin

				c2<=c1;
				c1<=c0;
				c0<=in;
			end
		end
		3:
		begin
			if(in>=c2)
			begin

				c3<=in;
			end
			else if(in>=c1)
			begin

				c3<=c2;
				c2<=in;
			end
			else if(in>=c0)
			begin

				c3<=c2;
				c2<=c1;
				c1<=in;
			end
			else
			begin

				c3<=c2;
				c2<=c1;
				c1<=c0;
				c0<=in;
			end
		end
		4:
		begin
			if(in>=c3)
			begin
				
				c4<=in;
			end
			else if(in>=c2)
			begin
				c4<=c3;
				c3<=in;
			end
			else if(in>=c1)
			begin

				c4<=c3;
				c3<=c2;
				c2<=in;
			end
			else if(in>=c0)
			begin

				c4<=c3;
				c3<=c2;
				c2<=c1;
				c1<=in;
			end
			else
			begin

				c4<=c3;
				c3<=c2;
				c2<=c1;
				c1<=c0;
				c0<=in;
			end
		end
		5:
		begin
			if(in>=c4)
			begin
				
				
				c5<=in;
			end
			else if(in>=c3)
			begin
				
				
				c5<=c4;
				c4<=in;
			end
			else if(in>=c2)
			begin
				
	
				c5<=c4;
				c4<=c3;
				c3<=in;
			end
			else if(in>=c1)
			begin
				
				
				c5<=c4;
				c4<=c3;
				c3<=c2;
				c2<=in;
			end
			else if(in>=c0)
			begin
				
				
				c5<=c4;
				c4<=c3;
				c3<=c2;
				c2<=c1;
				c1<=in;
			end
			else
			begin
				
				
				c5<=c4;
				c4<=c3;
				c3<=c2;
				c2<=c1;
				c1<=c0;
				c0<=in;
			end
		end
		6:
		begin
			if(in>=c5)
			begin
				c6<=in;
			end
			else if(in>=c4)
			begin
				
				c6<=c5;
				c5<=in;
			end
			else if(in>=c3)
			begin
				
				c6<=c5;
				c5<=c4;
				c4<=in;
			end
			else if(in>=c2)
			begin
				
				c6<=c5;
				c5<=c4;
				c4<=c3;
				c3<=in;
			end
			else if(in>=c1)
			begin
				
				c6<=c5;
				c5<=c4;
				c4<=c3;
				c3<=c2;
				c2<=in;
			end
			else if(in>=c0)
			begin
				
				c6<=c5;
				c5<=c4;
				c4<=c3;
				c3<=c2;
				c2<=c1;
				c1<=in;
			end
			else
			begin
				
				c6<=c5;
				c5<=c4;
				c4<=c3;
				c3<=c2;
				c2<=c1;
				c1<=c0;
				c0<=in;
			end
		end
		7:
		begin
			if(in>=c6)c7<=in;
			else if(in>=c5)
			begin
				c7<=c6;
				c6<=in;
			end
			else if(in>=c4)
			begin
				c7<=c6;
				c6<=c5;
				c5<=in;
			end
			else if(in>=c3)
			begin
				c7<=c6;
				c6<=c5;
				c5<=c4;
				c4<=in;
			end
			else if(in>=c2)
			begin
				c7<=c6;
				c6<=c5;
				c5<=c4;
				c4<=c3;
				c3<=in;
			end
			else if(in>=c1)
			begin
				c7<=c6;
				c6<=c5;
				c5<=c4;
				c4<=c3;
				c3<=c2;
				c2<=in;
			end
			else if(in>=c0)
			begin
				c7<=c6;
				c6<=c5;
				c5<=c4;
				c4<=c3;
				c3<=c2;
				c2<=c1;
				c1<=in;
			end
			else
			begin
				c7<=c6;
				c6<=c5;
				c5<=c4;
				c4<=c3;
				c3<=c2;
				c2<=c1;
				c1<=c0;
				c0<=in;
			end
		end
		default:now=now;
		endcase
		c=c+1;
		if(c==8)
		begin
			print=1;
			c=0;
		end
		else c=c;
	end
	
	else	c=c;


end
endmodule
