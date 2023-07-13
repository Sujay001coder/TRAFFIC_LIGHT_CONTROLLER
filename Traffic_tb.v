module simple_tb;
wire [1:0] hwy,lcl;
   reg X,clk,clr;
   initial
     begin
        $dumpfile("simple.vcd");
        $dumpvars(0, s);
$monitor($time,"Input is %d, Output is %d and %d,", X,hwy,lcl);
#7 X=0;
#7 X=1;
#7 X=1;
#7 X=0;
#7 X=1;
#7 X=1;
#7 X=1;
#7 X=1;
#7 X=0;
#7 X=0;
#7 X=0;
#150 $finish;
end
  always #5 clk = ~clk;
simple s(hwy,lcl,X,clk,clr);
endmodule
