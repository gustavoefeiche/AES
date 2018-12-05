#include "system.h"
#include <alt_types.h>
#include <io.h>
#include <stdio.h>

// LED Peripheral
#define REG_DATA_OFFSET 1
#define SM_ENABLE

int main(void) {
	volatile unsigned int *p_sm = (unsigned int *) SMCONTROLLER_0_BASE;

	*(p_sm+3) = 2048;

	while(1) {
		*(p_sm) = (0x1);
	}

	return 0;
}
