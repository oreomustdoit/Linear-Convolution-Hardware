
module convolution(clk,rst);
parameter M=6, N=8;
input clk,rst;
reg signed [15:0] A[M-1:0];
reg signed [15:0] B[N-1:0];
reg signed[31:0] Y[M+N-2:0];


reg signed [15:0] Atemp[M+N-2:0];
reg signed [15:0] Btemp[M+N-2:0];
reg signed [31:0] Ctemp[M+N-2:0];
reg signed [63:0]sum,cnt,cnt2;
integer i,j,k,l,m,o;
reg[2:0] state;
always @(posedge clk or posedge rst)
begin
if(rst)
begin
sum<=0;
state<=0;
cnt<=0;
cnt2<=0;
for(l=0;l<=M+N-2;l=l+1)
begin
Atemp[l]<=0;
Btemp[l]<=0;
Ctemp[l]<=0;
Y[l]<=0;
end
for(m=0;m<=M+N-2;m=m+1)
begin
A[l]<=0;
B[l]<=0;
end
end
else
begin
case(state)

0: begin
   for(i=0;i<=M+N-2;i=i+1)
   begin
   if(i<N-1) Atemp[i]<=0;
   else Atemp[i]<=A[i-N+1];

   if(i<=N-1) Btemp[i]<=B[N-1-i];
   else Btemp[i]<=0;
   state<=1;   
   end
   end
1: begin
   for(j=0;j<=M+N-2;j=j+1)
   begin
   Ctemp[j]<=Atemp[j]*Btemp[j];
   end
   if(cnt<=M+N-2)state<=2;
   else state<=4; 
   end
2: begin
   
   if(cnt2<=M+N-2) begin
   sum<=sum+Ctemp[cnt2];
   cnt2<=cnt2+1;
    state<=2;end
   else begin state<=3;cnt2<=0; end
   end
3: begin
   Y[cnt]<=sum;
   cnt<=cnt+1;
   for(o=0;o<=M+N-2;o=o+1)
   begin
   if(o==0) Btemp[o]<=Btemp[M+N-2];
   else Btemp[o]<=Btemp[o-1];
   end
   state<=1;
   sum<=0;
   o<=0;	
   end
4: begin
   cnt<=cnt;
   state<=4;
  
   end
default: state<=4;		

endcase
end
end


 
endmodule
