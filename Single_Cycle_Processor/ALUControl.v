`timescale 1ns / 1ps

module ALUControl (ALUCtrl, ALUop, Opcode);
input [1:0] ALUop;
input [10:0] Opcode;
output reg [3:0] ALUCtrl;

always @ (ALUop or Opcode)

begin
	if (ALUop == 2'b00) //1.ldur,stur
	ALUCtrl <= #20 4'b0010;

	else if(ALUop == 2'b01) //2.cbz
	ALUCtrl <= #20 4'b0111;

	else if(ALUop == 2'b10 && Opcode == 11'b11001011000) //3.sub	
	ALUCtrl <= #20 4'b0110;

	else if(ALUop == 2'b10 && Opcode == 11'b10101010000) //4.or
	ALUCtrl <= #20 4'b0001;

	else if(ALUop == 2'b10 && Opcode == 11'b10001010000) //5.and
	ALUCtrl <= #20 4'b0000;

	else if(ALUop == 2'b10 && Opcode == 11'b10001011000) //6.add
	ALUCtrl <= #20 4'b0010;
	else
	ALUCtrl <= #20 4'b1111;
end

endmodule


