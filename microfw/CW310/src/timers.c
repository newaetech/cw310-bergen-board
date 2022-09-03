/*
 * timers.c
 *
 * Created: 3/15/2021 6:25:38 PM
 *  Author: adewa
 */ 
#include <asf.h>
#include "thermal_power.h"
#include "timers.h"

#define PERIODIC_TIMER_CHANNEL 1

int periodic_timer_init(void)
{
	pmc_enable_periph_clk(ID_TC1); //ahhhhh
	
	tc_init(TC0, PERIODIC_TIMER_CHANNEL, TC_CMR_TCCLKS_TIMER_CLOCK1 | TC_CMR_CPCTRG | TC_CMR_WAVE);
	tc_write_rc(TC0, PERIODIC_TIMER_CHANNEL, sysclk_get_peripheral_bus_hz(TC0) / 2 / 4); //4 Hz
	
	tc_start(TC0, PERIODIC_TIMER_CHANNEL);
	tc_get_status(TC0, PERIODIC_TIMER_CHANNEL);
	
	NVIC_DisableIRQ(TC1_IRQn);
	NVIC_ClearPendingIRQ(TC1_IRQn);
	NVIC_SetPriority(TC1_IRQn, 8);
	NVIC_EnableIRQ(TC1_IRQn);
	tc_enable_interrupt(TC0, PERIODIC_TIMER_CHANNEL, TC_IER_CPCS);
	return 0x00;
}

volatile uint32_t periodic_tick_div = 0;
ISR(TC1_Handler)
{
	if (tc_get_status(TC0, PERIODIC_TIMER_CHANNEL) & (TC_IER_CPCS)) {
		thermals_fast_tick();
		periodic_tick_div++;
		if (!(periodic_tick_div % 8)) {
			thermals_slow_tick();
		}
		
		if (!(periodic_tick_div % 16)) {
			pgood_tick();
		}
	}
}
