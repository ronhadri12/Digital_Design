`timescale 1ns / 1ps

module NextPClogic(NextPC, CurrentPC, SignExtImm64, Branch, ALUZero, Uncondbranch);
       input [63:0] CurrentPC, SignExtImm64;
       input Branch, ALUZero, Uncondbranch;
       output reg [63:0] NextPC;
       always@ (*)

	begin

		if ((Branch && ALUZero) || Uncondbranch)  //CBZ
		begin
		NextPC = CurrentPC + (SignExtImm64 << 64'd2) ; // current + sig*2, shift by two
		end

		else // PC = PC + 4
		NextPC = CurrentPC + 64'd4;
	end

endmodule
