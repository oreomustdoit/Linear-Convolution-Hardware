
module tb;
parameter M=6, N=8;
reg clk=0;
reg rst=1;
integer i;
always #10 clk=!clk;

convolution DUT(clk,rst);

initial
begin
rst=1;#1;rst=0;
DUT.A[0]<=143;DUT.B[0]<=613;
DUT.A[1]<=236;DUT.B[1]<=218;
DUT.A[2]<=767;DUT.B[2]<=-300;
DUT.A[3]<=-321;DUT.B[3]<=824;
DUT.A[4]<=231;DUT.B[4]<=-510;
DUT.A[5]<=899;DUT.B[5]<=-323;
              DUT.B[6]<=-200;
              DUT.B[7]<=-200;
              
repeat(1000) @(posedge clk);
for(i=0;i<=M+N-2;i=i+1)
begin
$display("Y%1d=%d",i,DUT.Y[i]);
end
$finish;
end
endmodule