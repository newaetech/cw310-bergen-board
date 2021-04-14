/*
 * max1617.h
 *
 * Created: 3/15/2021 4:16:13 PM
 *  Author: adewa
 */ 


#ifndef MAX1617_H_
#define MAX1617_H_

int enable_switched_power(void);

int max1617_register_read(uint8_t reg_addr, int8_t *result);

int max1617_register_write(uint8_t reg_addr, int8_t data);

int thermals_init(void);

int8_t max1617_read_remote_temp(void);

int thermals_slow_tick(void);

int thermals_fast_tick(void);

void kill_fpga_power(void);

void enable_fpga_power(void);

void max1617_alert_handler(const uint32_t id, const uint32_t index);

int fan_pwm_init(void);
int fan_pwm_set_duty_cycle(uint8_t duty_cycle);

int pgood_tick(void);
int power_init(void);

void check_power_state(void);

enum max1617_registers {
	MAX1617_READ_LOCAL_TEMP,
	MAX1617_READ_REMOTE_TEMP,
	MAX1617_READ_STATUS,
	MAX1617_READ_CONFIG,
	MAX1617_READ_CONV_RATE,
	MAX1617_READ_LOCAL_THIGH,
	MAX1617_READ_LOCAL_TLOW,
	MAX1617_READ_REMOTE_THIGH,
	MAX1617_READ_REMOTE_TLOW,
	MAX1617_WRITE_CONFIG,
	MAX1617_WRITE_CONV_RATE,
	MAX1617_WRITE_LOCAL_THIGH,
	MAX1617_WRITE_LOCAL_TLOW,
	MAX1617_WRITE_REMOTE_THIGH,
	MAX1617_WRITE_REMOTE_TLOW,
	MAX1617_ONESHOT,	
};


#endif /* MAX1617_H_ */