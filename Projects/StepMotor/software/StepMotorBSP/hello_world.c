#include "system.h"
#include <alt_types.h>
#include <io.h>
#include <stdio.h>

// LED Peripheral
#define REG_DATA_OFFSET 1

int main(void) {
 volatile unsigned int *p_sm = (unsigned int *) SMCONTROLLER_0_BASE;

  while(1) {
	  *(p_sm+2) = (0x0);
	  *(p_sm) = (0x1);
	  usleep(1000000);
	  *(p_sm+2) = (0x1);
//	  *(p_sm) = (0x0);
	  usleep(1000000);
  }

  return 0;
}
