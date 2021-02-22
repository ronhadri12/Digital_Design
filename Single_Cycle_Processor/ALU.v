`timescale 1ns / 1ps
`define AND 4'b0000
`define OR 4'b0001
`define ADD 4'b0010
`define LSL 4'b0011
`define LSR 4'b0100
`define SUB 4'b0110
`define PassB 4'b0111


module ALU(BusW, BusA, BusB, ALUCtrl, Zero);
    
    parameter n = 64;

    output  [n-1:0] BusW;
    input   [n-1:0] BusA, BusB;
    input   [3:0] ALUCtrl;
    output  Zero;
    
    reg     [n-1:0] BusW;
    
    always @(ALUCtrl or BusA or BusB) begin
        case(ALUCtrl)
         `AND: begin
                BusW <= #20 BusA & BusB; //when And is called, you & it
         end
         `OR: begin
		BusW <= #20 BusA | BusB; //when Or, you |
	 end
	`ADD: begin
		BusW <= #20 BusA + BusB; //when Add is called, do +
	 end
	`LSL: begin
		BusW <= #20 BusA << BusB; //when LSL is called, do <<
	 end
	`LSR: begin
		BusW <= #20 BusA >> BusB; //when LSR is called, do >>
	 end
	`SUB: begin
		BusW <= #20 BusA - BusB; //when SUB is called, -
	 end
	`PassB: begin
		BusW <= #20 BusB; //when PassB is called, you & it
	 end

        endcase
    end

    assign #1 Zero = (BusW == 64'b0) ? 1 : 0; //if busw is equal to zero then set Zero to 0 and vice versa
endmodule
