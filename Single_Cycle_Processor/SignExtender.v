`timescale 1ns / 1ps

module SignExtender(Inst,BusImm);

output reg [63:0] BusImm;
input [31:0] Inst;

always @(*)
begin
	if(Inst[31:26] == 6'b000101 || Inst[31:26] == 6'b100101) //opcodes for B
		BusImm = {{38{Inst[25]}},Inst[25:0]}; //Type B

	else if (Inst[31:24] == 8'b01010100 || Inst[31:24] == 8'b10110100 || Inst[31:24] == 8'b10110101) //opcodes for cb
		BusImm = {{45{Inst[23]}},Inst[23:5]}; //Type CB

	else if (Inst[31:21] == 11'b00111000000 || Inst[31:21] == 11'b00111000010 || Inst[31:21] == 11'b01111000000 || 
		 Inst[31:21] == 11'b01111000010 || Inst[31:21] == 11'b11111000000 || Inst[31:21] == 11'b11111000010) //opcode for D
		BusImm = {{55{Inst[20]}},Inst[20:12]}; //Type D
	else
		BusImm = 64'b0; //default
end


endmodule
