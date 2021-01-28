module SRAM (Address, InData, OutData, bCE, bWE);
	
	parameter AddressSize = 18;		// 2^18 = 256K
	parameter WordSize = 8;			// 8 bits
	
	// Port Declaration
	input wire [AddressSize-1:0] Address;
	input wire [WordSize-1:0] InData;
	input wire bCE;
	input wire bWE;
	output reg [WordSize-1:0] OutData;
	
	// Internal Variable
	reg [WordSize-1:0] RAM_DATA[0:(1<<AddressSize)-1];
	
	// Function Read
	always @(bCE or bWE or Address)
		begin
			if(!bCE && bWE) // bCE = 0 and bWE = 1 
				begin
					OutData <= RAM_DATA[Address];
				end
			else
				OutData <=8'bz; // tri state cond.
		end
	
	// Function Write
	always @(bCE or bWE or Address or InData)
		begin
			if(!bCE && !bWE) // bCE & bWE both == 0
				begin
					RAM_DATA[Address]<= InData;
				end
		end

endmodule
