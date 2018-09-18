#include <stdio.h>
#include "system.h"
#include <alt_types.h>
#include "altera_avalon_pio_regs.h"
#include "sys/alt_irq.h"
#include <io.h>
#include <unistd.h>


void handle_button_interrupts(void* context, alt_u32 id);
void init_pio();


volatile int edge_capture = 3;

int n;
volatile int f_print;
volatile int g_edge;

int main(void){
	n = 0;
	f_print = 0;
	unsigned int led = 0;

	init_pio();

	printf("Starting BlinkLED \n");

	while(1) {
		if (led <= 5) {
			IOWR_32DIRECT(PIO_0_BASE, 0, 0x01 << led++);
			usleep(50000);
		}
		else {
			led = 0;
		}

		if(f_print) {
			printf("%d\n", n);
			f_print = 0;
		}
	};

	return 0;
}

void init_pio() {
     /* Recast the edge_capture pointer to match the alt_irq_register() function
      * prototype. */
     /* Enable PIO interrupts */
     IOWR_ALTERA_AVALON_PIO_IRQ_MASK(PIO_1_BASE, 0x1f); // 0x1f = 00000000000000000000000000011111
     /* Reset the edge capture register. */
     IOWR_ALTERA_AVALON_PIO_EDGE_CAP(PIO_1_BASE, 0x0);
     /* Register the interrupt handler. */
     alt_irq_register( PIO_1_IRQ, NULL,
                       handle_button_interrupts );
 }

void handle_button_interrupts(void* context, alt_u32 id) {


     g_edge =  IORD_ALTERA_AVALON_PIO_EDGE_CAP(PIO_1_BASE);

     /* Reset the Button's edge capture register. */
     IOWR_ALTERA_AVALON_PIO_EDGE_CAP(PIO_1_BASE, 0);

     /* Increment counter */
     n++;

     /* Toggle printing flag */
     f_print = 1;
}
