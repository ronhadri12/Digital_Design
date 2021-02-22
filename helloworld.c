#include <stdio.h>
#include "platform.h"
#include <xparameters.h>
#include <multiply.h>

void print(char *str);

int main()
{
    init_platform();

    // declare variables to store values for slv_reg0, slv_reg1, and slv_reg2
    uint32_t slv_reg0 = 0;
    uint32_t slv_reg1 = 0;
    uint32_t slv_reg2 = 0;

    // declare variables to go through loops
    int i = 0;
    int j = 0;

    // increment through all possible values of inputs to get all possible output values & print them to terminal
    for(slv_reg0 = 0; slv_reg0 <= 16; slv_reg0++) {
    	MULTIPLY_mWriteReg(0x43C00000, 0, slv_reg0);
    	for(slv_reg1 = 0; slv_reg1 <= 16; slv_reg1++) {
    	    MULTIPLY_mWriteReg(0x43C00000, 4, slv_reg1);

    	    slv_reg2 = MULTIPLY_mReadReg(0x43C00000, 8);

    	    printf("slv_reg0 = %d, slv_reg1 = %d, slv_reg2 = %d\n", slv_reg0, slv_reg1, slv_reg2);

    	}
    }

    cleanup_platform();
    return 0;
}
