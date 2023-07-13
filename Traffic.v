module simple(hwy,lcl,X,clk,clr);

   input X;//If 1 then car is on the local road
input clk;
input clr;
   output reg[1:0] hwy,lcl;
parameter TRUE=1'b1;
parameter FALSE=1'b0;
parameter RED=2'b00;
parameter YELLOW=2'b01;
parameter GREEN=2'b10;
parameter S0=3'b000;
parameter S1=3'b001;
parameter S2=3'b010;
parameter S3=3'b011;
parameter S4=3'b100;
//Delays defining some delays when there is a transition from yellow to red and red to green
parameter Y2Rdel=3;
parameter R2Gdel=2;
reg[2:0] cs;
reg[2:0] ns;
initial
begin
cs=S0;
hwy=GREEN;
lcl=RED;
end
always @(posedge clk,posedge clr)
if(clr==1)
cs <=S0;
else
cs <=ns;
end
always @(cs)
begin
case(cs)
S0:begin
hwy <=GREEN;
lcl <=RED;
end 
S1:begin
hwy <=YELLOW;
lcl <=RED;
end 
S2:begin
hwy <=RED;
lcl <=RED;
end 
S3:begin
hwy <=RED;
lcl <=GREEN;
end 
S4:begin
hwy <=RED;
lcl <=YELLOW;
end 
endcase
end
always @(cs or clr or X)
begin
if(clr)
ns<=S0;
else
case(cs)
S0: if(X)
ns<=S1;
else
ns<=S0;
S1: begin // delaying some of the clock pulses
  repeat(Y2Rdel)@(posedge clk);//3 clock pulses when transitioning from yellow to red light
ns<=S2;
end
S2: begin
  repeat(R2Gdel)@(posedge clk);//2 clock pulses when transitioning from red to green light
ns<=S3;
end
S3: if(X)
ns<=S3;
else
ns<=S4;
S4: begin
repeat(Y2Rdel)@(posedge clk);
ns<=S0;
end
default: ns<=S0;
endcase
end
endmodule
