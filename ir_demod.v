`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/30/2018 09:21:14 PM
// Design Name: 
// Module Name: ir_demod
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module ir_demod(
	input CLK,
	input RST,
	input ir_signal,
	output [31:0] slv_reg0,
	output [31:0] slv_reg1,
	output [31:0] slv_reg2,
	output [31:0] slv_reg3
    );
	reg [11:0] holder;			// holds 12 bits from the test vectors
	reg ir_posedge;				// detects a positive edge in the IR signal
	reg ir_negedge;				// detects a negative edge in the IR signal
	reg prev_ir_signal;			// stores the previous value of the IR signal
	reg [31:0] count;			// divides clock
	reg [31:0] counter;			// implements logic
	reg [3:0] countBits;      		// count the number of bits in the holder register
	reg [31:0] temp_reg0;			// temporary slave register 0
	reg [31:0] temp_reg1;			// temporary slave register 1
	reg OutClk;                         	// declare new slower clock
	
	always@(posedge OutClk) begin
                prev_ir_signal <= ir_signal;
		if((prev_ir_signal == 1'b0) && (ir_signal == 1'b1)) begin
		    ir_posedge <= 1'b1;
		end
		else if((prev_ir_signal == 1'b1) && (ir_signal == 1'b0)) begin
		    ir_negedge <= 1'b1;
		end
		else begin
		    ir_posedge <= 0;
		    ir_negedge <= 0;
		end
        end

	always@(posedge OutClk or negedge RST) begin
		if(RST == 0) begin 
			holder <= 0;
			count <= 0;
			counter <= 0;
			countBits <= 0;
			temp_reg0 <= 0;
			temp_reg1 <= 0;
		end 
		else if(ir_negedge) begin 
			counter <= 1;
		end
		else if(ir_posedge) begin 

			if((counter >= 20) && (counter <= 90)) begin
				holder <= holder << 1;
				countBits <= countBits + 1;
			end
			else if((counter >= 91) && (counter <= 180)) begin
				holder <= (holder << 1) | 1;
				countBits <= countBits + 1;
			end
			else if((counter >= 181) && (counter <= 250)) begin
				holder <= 0;
				countBits <= 0;
			end
			counter <= 0;
		end
		else if(counter > 0) begin
			counter <= counter + 1;
		end
            	else if(countBits == 12) begin
			temp_reg0 <= holder;
			temp_reg1 <= temp_reg1 + 1;
			countBits <= 0;
		end
	end

	// implementing the clock divider to get a 100kHz clock instead of a 75MHz one
	always@(posedge CLK) begin
	        if(RST == 0) begin
	        	count <= 0;
	        	OutClk <= 0;
	        end
	        else if(count == 750) begin
			count <= 0;
			OutClk <= 1;
	        end
	        else begin
	        	count <= count + 1;
	        	OutClk <= 0;
	        end
	end
    
	assign slv_reg0 = temp_reg0;
	assign slv_reg1 = temp_reg1;

endmodule
