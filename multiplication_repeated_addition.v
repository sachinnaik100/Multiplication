module multiplication_repeated_addition(eqz,LdA,LdB,LdP,clrP,decB,data_in,clk);
input LdA,LdB,LdP,clrP,decB,clk;
input [15:0] data_in;
output eqz;
wire [15:0] X,Y,Z,Bout,Bus;
PIPO1 A(X,Bus,LdA,clk);
PIPO2 P(Y,Z,LdP,clrP,clk);
CNTR B(Bout,Bus,LdB,decB,clk);
ADD AD(Z,X,Y);
EQZ COMP(eqz,Bout);
endmodule

module PIPO1(data_out,data_in,load,clk);
input load,clk;
input [15:0] data_in;
output reg [15:0] data_out;
always @ (posedge clk)
if (load) data_out<=data_in;
endmodule

module PIPO2(dout,din,ld,clr,clk);
input ld,clk,clr;
output reg [15:0] dout;
input [15:0] din;
always @ (posedge clk)
begin
if(clr) dout<={16{1'b0}};
else if(ld) dout<=din;
end
endmodule

module CNTR(dout,din,ld,dec,clk);
input [15:0] din;
output reg [15:0] dout;
input clk,ld,dec;
always @ (posedge clk)
begin
if(ld) dout<=din;
else if (dec) dout<=dout-1;
end
endmodule

module ADD(out,in1,in2);
input [15:0] in1,in2;
output reg [15:0] out;
always @ (*)
out=in1+in2;
endmodule

module EQZ(eqz,data);
input [15:0] data;
output eqz;
assign eqz=(data==0);
endmodule






