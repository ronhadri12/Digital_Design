`timescale 1ns / 1ps

module RegisterFile(BusA, BusB, BusW,RA, RB, RW, RegWr, Clk);
    output [63:0] BusA;
    output [63:0] BusB;
    input [63:0] BusW;
    input [4:0] RA;
    input [4:0] RW;
    input [4:0] RB;
    input RegWr;
    input Clk;
    reg [63:0] registers [31:0];

    wire [63:0] reg31;
    
    assign reg31 = 64'b0;                        //register 31 is alwasy 0 
    assign #2 BusA = registers[RA];               //Bus A is register[RA]
    assign #2 BusB = registers[RB];               //Bus B is register[RB]
	
    always @ (*)
	begin
		registers[31] <= #2 reg31;        //when register 31 is called, register31 = 0
	end
     
    always @ (negedge Clk) 
	begin
        if(RegWr && RW != 5'd31 )
            registers[RW] <= #3 BusW;              //when write = 1 and not equal to register 31
	else
	    registers[RW] <= #3 registers[RW];    	//when write 0;
    end
endmodule
