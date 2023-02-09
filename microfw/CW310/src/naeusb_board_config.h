/*
 * CW340_pins.h
 *
 * Created: 1/27/2021 8:15:46 AM
 *  Author: adewa
 */

#ifdef __PLAT_CW340__

extern volatile uint8_t I2C_LOCK;



#ifndef CW340_PINS_H_
#define CW340_PINS_H_
/** Board oscillator settings */
#define BOARD_FREQ_SLCK_XTAL        (0U)
#define BOARD_FREQ_SLCK_BYPASS      (0U)
#define BOARD_FREQ_MAINCK_XTAL      (12000000U)
#define BOARD_FREQ_MAINCK_BYPASS    (12000000U)

void enable_fpga_power(void);
void kill_fpga_power(void);
#define board_power(a)	 if (a){enable_fpga_power();} else {kill_fpga_power();}

#define SPI SPI0

/** Master clock frequency */
#define BOARD_MCK                   CHIP_FREQ_CPU_MAX

/** board main clock xtal startup time */
#define BOARD_OSC_STARTUP_US   15625
//#define CONFIG_USBCLK_SOURCE CONFIG_PLL1_SOURCE

#define FPGA_PROG_USART			USART2
#define FPGA_PROG_USART_ID		ID_USART2

#define PIN_FPGA_INITB_GPIO		PIO_PB18_IDX
#define PIN_FPGA_DONE_GPIO		PIO_PB17_IDX
#define PIN_FPGA_PROGRAM_GPIO	PIO_PB19_IDX

#define PIN_FPGA_CCLK_GPIO		PIO_PB24_IDX

#define SPI_MOSI_GPIO PIO_PA26_IDX
#define SPI_MISO_GPIO PIO_PA25_IDX
#define SPI_SPCK_GPIO PIO_PA27_IDX

#define SPI_MOSI_FLAGS PIO_PERIPH_A | PIO_DEFAULT
#define SPI_SPCK_FLAGS PIO_PERIPH_A | PIO_DEFAULT

#define BOARD_NF_DATA_ADDR      0x61000000 //might not be right

//Not Used #define PIN_USB_RESET		PIO_PC14_IDX

#define PIN_SAM3X_AUXPOWER_NENABLE PIO_PA4_IDX

/* Turn on Clock to FPGA */
#define CONF_BOARD_PCK0
#define PIN_PCK0			PIO_PB22_IDX
#define PIN_PCK0_FLAGS		PIO_PERIPH_B

#define PIN_EBI_DATA_BUS_D0 PIO_PC2_IDX
#define PIN_EBI_DATA_BUS_D1 PIO_PC3_IDX
#define PIN_EBI_DATA_BUS_D2 PIO_PC4_IDX
#define PIN_EBI_DATA_BUS_D3 PIO_PC5_IDX
#define PIN_EBI_DATA_BUS_D4 PIO_PC6_IDX
#define PIN_EBI_DATA_BUS_D5 PIO_PC7_IDX
#define PIN_EBI_DATA_BUS_D6 PIO_PC8_IDX
#define PIN_EBI_DATA_BUS_D7 PIO_PC9_IDX
#define PIN_EBI_DATA_BUS_D8 PIO_PC10_IDX
#define PIN_EBI_DATA_BUS_D9 PIO_PC11_IDX
#define PIN_EBI_DATA_BUS_D10 PIO_PC12_IDX
#define PIN_EBI_DATA_BUS_D11 PIO_PC13_IDX
#define PIN_EBI_DATA_BUS_D12 PIO_PC14_IDX
#define PIN_EBI_DATA_BUS_D13 PIO_PC15_IDX
#define PIN_EBI_DATA_BUS_D14 PIO_PC16_IDX
#define PIN_EBI_DATA_BUS_D15 PIO_PC17_IDX

#define PIN_EBI_DATA_BUS_FLAG1  PIO_PERIPH_A | PIO_PULLUP

/** EBI NRD pin */
#define PIN_EBI_NRD                 PIO_PA29_IDX
#define PIN_EBI_NRD_FLAGS       PIO_PERIPH_B | PIO_PULLUP
#define PIN_EBI_NRD_MASK  1 << 29
#define PIN_EBI_NRD_PIO  PIOA
#define PIN_EBI_NRD_ID  ID_PIOA
#define PIN_EBI_NRD_TYPE PIO_PERIPH_B
#define PIN_EBI_NRD_ATTR PIO_PULLUP

/** EBI NWE pin */
#define PIN_EBI_NWE                  PIO_PC18_IDX
#define PIN_EBI_NWE_FLAGS       PIO_PERIPH_A | PIO_DEFAULT
#define PIN_EBI_NWE_MASK  1 << 18
#define PIN_EBI_NWE_PIO  PIOC
#define PIN_EBI_NWE_ID  ID_PIOC
#define PIN_EBI_NWE_TYPE PIO_PERIPH_A
#define PIN_EBI_NWE_ATTR PIO_PULLUP

/** EBI NCS0 pin */
#define PIN_EBI_NCS0                PIO_PA6_IDX
#define PIN_EBI_NCS0_FLAGS     PIO_PERIPH_B | PIO_PULLUP
#define PIN_EBI_NCS0_MASK  1 << 6
#define PIN_EBI_NCS0_PIO  PIOA
#define PIN_EBI_NCS0_ID  ID_PIOA
#define PIN_EBI_NCS0_TYPE PIO_PERIPH_B
#define PIN_EBI_NCS0_ATTR PIO_PULLUP

//#define FPGA_ADDR_PINS (PIO_PC21 | PIO_PB1 | PIO_PC22 | PIO_PC23 | PIO_PC24 | PIO_PC25 | PIO_PC26 | PIO_PC27 )
//#define FPGA_ADDR_PORT PIOC

/* Technically SPARE3 */
#define FPGA_ALE_GPIO		 (PIO_PC24_IDX)
#define FPGA_ALE_FLAGS		 (PIO_TYPE_PIO_OUTPUT_1 | PIO_DEFAULT)

#define PIN_CDCE_SDA PIO_PA17_IDX
#define PIN_CDCE_SCL PIO_PA18_IDX

#define PIN_PWD_SDA PIN_CDCE_SDA
#define PIN_PWD_SCL PIN_CDCE_SCL

#define PIN_EBI_DATA_BUS_FLAG1   PIO_PERIPH_A | PIO_PULLUP
#define PIN_CDCE_SDA_FLAGS  (PIO_PERIPH_A | PIO_PULLUP)
#define PIN_CDCE_SCL_FLAGS  (PIO_PERIPH_A | PIO_PULLUP)
#define PIN_PWD_SDA_FLAGS (PIO_PERIPH_A | PIO_PULLUP)
#define PIN_PWD_SCL_FLAGS (PIO_PERIPH_A | PIO_PULLUP)

//HERE
#define PIN_FPGA_DO_GPIO PIO_PB20_IDX
//HERE

#define PIN_SPARE1 PIO_PC21_IDX
#define PIN_SPARE2 PIO_PC22_IDX

#define PIN_USART0_RXD PIO_PA10_IDX
#define PIN_USART0_TXD PIO_PA11_IDX
#define PIN_USART0_RXD_FLAGS PIO_PERIPH_A | PIO_DEFAULT
#define PIN_USART0_TXD_FLAGS PIO_PERIPH_A | PIO_DEFAULT

#define PIN_USART1_RXD PIO_PA12_IDX
#define PIN_USART1_TXD PIO_PA13_IDX
#define PIN_USART1_RXD_IDX PIO_PA12_IDX
#define PIN_USART1_TXD_IDX PIO_PA13_IDX
#define PIN_USART1_RXD_FLAGS PIO_PERIPH_A | PIO_DEFAULT
#define PIN_USART1_TXD_FLAGS PIO_PERIPH_A | PIO_DEFAULT

#define CW_USE_USART0 1
#define CW_USE_USART1 1

#define FPGA_USE_BITBANG 0
#define FPGA_USE_USART 0

#if FPGA_USE_BITBANG
#define PIN_FPGA_DO_FLAGS			(PIO_TYPE_PIO_OUTPUT_0 | PIO_DEFAULT)
#define PIN_FPGA_CCLK_FLAGS		(PIO_TYPE_PIO_OUTPUT_0 | PIO_DEFAULT)
#else
#define PIN_FPGA_CCLK_FLAGS		(PIO_PERIPH_A | PIO_DEFAULT)
#define PIN_FPGA_DO_FLAGS			(PIO_PERIPH_A | PIO_DEFAULT)
#endif

//THERMALS
#define PIN_TEMP_ALERT_PORT PIOA
#define PIN_TEMP_ALERT_PIN PIO_PA23
#define PIN_TEMP_ALERT PIO_PA23_IDX
#define PIN_TEMP_ALERT_FLAGS PIO_TYPE_PIO_INPUT | PIO_DEFAULT

#define PIN_FPGA_FAN_PWM PIO_PB25_IDX
#define PIN_FPGA_FAN_PWM_FLAGS PIO_PERIPH_B | PIO_DEFAULT

#define PIN_TEMP_ERR_LED PIO_PA0_IDX
#define PIN_TEMP_ERR_LED_FLAGS PIO_OUTPUT_0 | PIO_DEFAULT

#define PIN_TEMP_OK_LED PIO_PA1_IDX
#define PIN_TEMP_OK_LED_FLAGS PIO_OUTPUT_1 | PIO_DEFAULT

#define PIN_FPGA_PWR_ENABLE PIO_PB27_IDX
#define PIN_FPGA_PWR_ENABLE_FLAGS PIO_OUTPUT_0 | PIO_DEFAULT

#define PIN_SAM_SWITCHED_PWR_ENABLE PIO_PA4_IDX
#define PIN_SAM_SWITCHED_PWR_ENABLE_FLAGS PIO_OUTPUT_0 | PIO_DEFAULT

#define PIN_PGOOD_VCCINT PIO_PB10_IDX
#define PIN_PGOOD_VCCINT_FLAGS PIO_TYPE_PIO_INPUT | PIO_DEGLITCH | PIO_DEBOUNCE
#define PIN_PGOOD_VCCINT_PORT PIOC
#define PIN_PGOOD_VCCINT_PIN PIO_PC16

#define PIN_PGOOD_1V2 PIO_PB8_IDX
#define PIN_PGOOD_1V2_FLAGS PIO_TYPE_PIO_INPUT | PIO_DEFAULT
#define PIN_PGOOD_1V2_PORT PIOC
#define PIN_PGOOD_1V2_PIN PIO_PC19

#define PIN_PGOOD_1V8 PIO_PB9_IDX
#define PIN_PGOOD_1V8_FLAGS PIO_TYPE_PIO_INPUT | PIO_DEFAULT
#define PIN_PGOOD_1V8_PORT PIOC
#define PIN_PGOOD_1V8_PIN PIO_PC20

#define PIN_PGOOD_3V3 PIO_PB11_IDX
#define PIN_PGOOD_3V3_FLAGS PIO_TYPE_PIO_INPUT | PIO_DEFAULT
#define PIN_PGOOD_3V3_PORT PIOB
#define PIN_PGOOD_3V3_PIN PIO_PB11

#define PIN_SWSTATE_GPIO  PIO_PB26_IDX
#define PIN_SWSTATE_FLAGS  (PIO_TYPE_PIO_INPUT | PIO_DEFAULT)
#define board_get_powerstate()  gpio_pin_is_high(PIO_PB26_IDX)

#define FPGA_TRIGGER_GPIO PIO_PC23_IDX
#define FPGA_TRIGGER_FLAGS PIO_OUTPUT_0 | PIO_DEFAULT

#define PIN_USB_HBEAT PIO_PA3_IDX
#define PIN_USB_HBEAT_FLAGS (PIO_TYPE_PIO_OUTPUT_1 | PIO_DEFAULT)

#define PIN_FPGA_POWER_RESET PIO_PB23_IDX
#define PIN_FPGA_POWER_RESET_FLAGS PIO_TYPE_PIO_INPUT | PIO_DEGLITCH | PIO_DEBOUNCE | PIO_PULLUP
#define PIN_FPGA_POWER_RESET_PORT PIOB
#define PIN_FPGA_POWER_RESET_PIN PIO_PB23

#define PIN_FPGA_M0 PIO_PA19_IDX
#define PIN_FPGA_M0_FLAGS PIO_INPUT | PIO_DEFAULT

#define PIN_FPGA_M1 PIO_PA20_IDX
#define PIN_FPGA_M1_FLAGS PIO_INPUT | PIO_DEFAULT

#define PIN_FPGA_M2 PIO_PA21_IDX
#define PIN_FPGA_M2_FLAGS PIO_INPUT | PIO_DEFAULT

#define PIN_VBUS_DETECT       (PIO_PC15_IDX)
#define PIN_VBUS_DETECT_FLAGS (PIO_TYPE_PIO_INPUT | PIO_DEFAULT)

#endif

#else

/*
 * CW305_plus_pins.h
 *
 * Created: 1/27/2021 8:15:46 AM
 *  Author: adewa
 */ 

extern volatile uint8_t I2C_LOCK;



#ifndef CW305_PLUS_PINS_H_
#define CW305_PLUS_PINS_H_
/** Board oscillator settings */
#define BOARD_FREQ_SLCK_XTAL        (0U)
#define BOARD_FREQ_SLCK_BYPASS      (0U)
#define BOARD_FREQ_MAINCK_XTAL      (12000000U)
#define BOARD_FREQ_MAINCK_BYPASS    (12000000U)



#define SPI SPI0

/** Master clock frequency */
#define BOARD_MCK                   CHIP_FREQ_CPU_MAX

/** board main clock xtal startup time */
#define BOARD_OSC_STARTUP_US   15625
//#define CONFIG_USBCLK_SOURCE CONFIG_PLL1_SOURCE

void enable_fpga_power(void);
void kill_fpga_power(void);
#define board_power(a)	 if (a){enable_fpga_power();} else {kill_fpga_power();}

#define PIN_FPGA_INITB_GPIO		PIO_PB18_IDX
#define PIN_FPGA_DONE_GPIO		PIO_PB17_IDX
#define PIN_FPGA_PROGRAM_GPIO	PIO_PB19_IDX

#define PIN_FPGA_CCLK_GPIO		PIO_PB24_IDX

#define SPI_FPGA USART2

#define SPI_MOSI_GPIO PIO_PB20_IDX
#define SPI_MISO_GPIO PIO_PB21_IDX
#define SPI_SPCK_GPIO PIO_PB24_IDX

#define SPI_MOSI_FLAGS PIO_PERIPH_A | PIO_DEFAULT
#define SPI_SPCK_FLAGS PIO_PERIPH_A | PIO_DEFAULT

#define BOARD_NF_DATA_ADDR      0x61000000 //might not be right

#define PIN_USB_RESET		PIO_PC14_IDX
	
#define PIN_SAM3X_AUXPOWER_NENABLE PIO_PA4_IDX
	
/* Turn on Clock to FPGA */
#define CONF_BOARD_PCK0
#define PIN_PCK0			PIO_PB22_IDX
#define PIN_PCK0_FLAGS		PIO_PERIPH_B

#define PIN_EBI_DATA_BUS_D0 PIO_PC2_IDX
#define PIN_EBI_DATA_BUS_D1 PIO_PC3_IDX
#define PIN_EBI_DATA_BUS_D2 PIO_PC4_IDX
#define PIN_EBI_DATA_BUS_D3 PIO_PC5_IDX
#define PIN_EBI_DATA_BUS_D4 PIO_PC6_IDX
#define PIN_EBI_DATA_BUS_D5 PIO_PC7_IDX
#define PIN_EBI_DATA_BUS_D6 PIO_PC8_IDX
#define PIN_EBI_DATA_BUS_D7 PIO_PC9_IDX

#define MPSSE_DOUT_GPIO PIO_PA26_IDX
#define MPSSE_DIN_GPIO  PIO_PA25_IDX
#define MPSSE_SCK_GPIO  PIO_PA27_IDX
#define MPSSE_TMS_GPIO  PIO_PA28_IDX
#define MPSSE_GPIOL0    PIO_PD3_IDX /* USB_A13 */
#define MPSSE_GPIOL1    PIO_PD4_IDX /* USB_A14 */
#define MPSSE_GPIOL2    PIO_PD8_IDX /* USB_A18 */
#define MPSSE_GPIOL3    PIO_PD9_IDX /* USB_A19 */

#define PIN_EBI_DATA_BUS_FLAG1  PIO_PERIPH_A | PIO_PULLUP

#define PIN_EBI_ADDR_BUS_A0		PIO_PC21_IDX
#define PIN_EBI_ADDR_BUS_A1		PIO_PC22_IDX
#define PIN_EBI_ADDR_BUS_A2		PIO_PC23_IDX
#define PIN_EBI_ADDR_BUS_A3		PIO_PC24_IDX
#define PIN_EBI_ADDR_BUS_A4		PIO_PC25_IDX
#define PIN_EBI_ADDR_BUS_A5		PIO_PC26_IDX
#define PIN_EBI_ADDR_BUS_A6		PIO_PC27_IDX
#define PIN_EBI_ADDR_BUS_A7		PIO_PC28_IDX
#define PIN_EBI_ADDR_BUS_A8		PIO_PC29_IDX
#define PIN_EBI_ADDR_BUS_A9		PIO_PC30_IDX
#define PIN_EBI_ADDR_BUS_A10	PIO_PD0_IDX
#define PIN_EBI_ADDR_BUS_A11	PIO_PD1_IDX
#define PIN_EBI_ADDR_BUS_A12	PIO_PD2_IDX
#define PIN_EBI_ADDR_BUS_A13	PIO_PD3_IDX
#define PIN_EBI_ADDR_BUS_A14	PIO_PD4_IDX
#define PIN_EBI_ADDR_BUS_A15	PIO_PD5_IDX
#define PIN_EBI_ADDR_BUS_A16	PIO_PD6_IDX
#define PIN_EBI_ADDR_BUS_A17	PIO_PD7_IDX
#define PIN_EBI_ADDR_BUS_A18	PIO_PD8_IDX
#define PIN_EBI_ADDR_BUS_A19	PIO_PD9_IDX

#define PIN_EBI_ADDR_BUS_FLAG1  PIO_PERIPH_A | PIO_PULLUP

/** EBI NRD pin */
#define PIN_EBI_NRD                 PIO_PA29_IDX
#define PIN_EBI_NRD_FLAGS       PIO_PERIPH_B | PIO_PULLUP
#define PIN_EBI_NRD_MASK  1 << 29
#define PIN_EBI_NRD_PIO  PIOA
#define PIN_EBI_NRD_ID  ID_PIOA
#define PIN_EBI_NRD_TYPE PIO_PERIPH_B
#define PIN_EBI_NRD_ATTR PIO_PULLUP

/** EBI NWE pin */
#define PIN_EBI_NWE                  PIO_PC18_IDX
#define PIN_EBI_NWE_FLAGS       PIO_PERIPH_A | PIO_PULLUP
#define PIN_EBI_NWE_MASK  1 << 18
#define PIN_EBI_NWE_PIO  PIOC
#define PIN_EBI_NWE_ID  ID_PIOC
#define PIN_EBI_NWE_TYPE PIO_PERIPH_A
#define PIN_EBI_NWE_ATTR PIO_PULLUP

/** EBI NCS0 pin */
#define PIN_EBI_NCS0                PIO_PA6_IDX
#define PIN_EBI_NCS0_FLAGS     PIO_PERIPH_B | PIO_PULLUP
#define PIN_EBI_NCS0_MASK  1 << 6
#define PIN_EBI_NCS0_PIO  PIOA
#define PIN_EBI_NCS0_ID  ID_PIOA
#define PIN_EBI_NCS0_TYPE PIO_PERIPH_B
#define PIN_EBI_NCS0_ATTR PIO_PULLUP

#define FPGA_ADDR_PINS (PIO_PC21 | PIO_PB1 | PIO_PC22 | PIO_PC23 | PIO_PC24 | PIO_PC25 | PIO_PC26 | PIO_PC27 )
#define FPGA_ADDR_PORT PIOC

#define FPGA_ALE_GPIO		 (PIO_PC17_IDX)
#define FPGA_ALE_FLAGS		 (PIO_TYPE_PIO_OUTPUT_1 | PIO_DEFAULT)

#define PIN_CDCE_SDA PIO_PA17_IDX
#define PIN_CDCE_SCL PIO_PA18_IDX

#define PIN_PWD_SDA PIN_CDCE_SDA
#define PIN_PWD_SCL PIN_CDCE_SCL

#define PIN_EBI_DATA_BUS_FLAG1   PIO_PERIPH_A | PIO_PULLUP
#define PIN_CDCE_SDA_FLAGS  (PIO_PERIPH_A | PIO_PULLUP)
#define PIN_CDCE_SCL_FLAGS  (PIO_PERIPH_A | PIO_PULLUP)
#define PIN_PWD_SDA_FLAGS (PIO_PERIPH_A | PIO_PULLUP)
#define PIN_PWD_SCL_FLAGS (PIO_PERIPH_A | PIO_PULLUP)

#define PIN_FPGA_DO_GPIO SPI_MOSI_GPIO
#define PIN_FPGA_DI_GPIO SPI_MISO_GPIO
#define PIN_SPARE1 PIN_FPGA_DO_GPIO
#define PIN_SPARE2 PIN_FPGA_DI_GPIO
	
#define PIN_USART0_RXD PIO_PA10_IDX
#define PIN_USART0_TXD PIO_PA11_IDX
#define PIN_USART0_RXD_FLAGS PIO_PERIPH_A | PIO_DEFAULT
#define PIN_USART0_TXD_FLAGS PIO_PERIPH_A | PIO_DEFAULT

#define PIN_USART1_RXD PIO_PA12_IDX
#define PIN_USART1_TXD PIO_PA13_IDX
#define PIN_USART1_RXD_IDX PIO_PA12_IDX
#define PIN_USART1_TXD_IDX PIO_PA13_IDX
#define PIN_USART1_RXD_FLAGS PIO_PERIPH_A | PIO_DEFAULT
#define PIN_USART1_TXD_FLAGS PIO_PERIPH_A | PIO_DEFAULT



#define CW_USE_USART0 1
#define CW_USE_USART1 1 


#define FPGA_PROG_USART			USART2
#define FPGA_PROG_USART_ID		ID_USART2

#if FPGA_USE_BITBANG
#define PIN_FPGA_DO_FLAGS			(PIO_TYPE_PIO_OUTPUT_0 | PIO_DEFAULT)
#define PIN_FPGA_CCLK_FLAGS		(PIO_TYPE_PIO_OUTPUT_0 | PIO_DEFAULT)
#else
#define PIN_FPGA_CCLK_FLAGS		(PIO_PERIPH_A | PIO_DEFAULT)
#define PIN_FPGA_DO_FLAGS			(PIO_PERIPH_A | PIO_DEFAULT)
#endif

#define FPGA_USE_USART 1

//THERMALS
#define PIN_TEMP_ALERT_PORT PIOA
#define PIN_TEMP_ALERT_PIN PIO_PA23
#define PIN_TEMP_ALERT PIO_PA23_IDX
#define PIN_TEMP_ALERT_FLAGS PIO_TYPE_PIO_INPUT | PIO_DEFAULT

#define PIN_FPGA_FAN_PWM PIO_PB25_IDX
#define PIN_FPGA_FAN_PWM_FLAGS PIO_PERIPH_B | PIO_DEFAULT

#define PIN_TEMP_ERR_LED PIO_PA0_IDX
#define PIN_TEMP_ERR_LED_FLAGS PIO_OUTPUT_0 | PIO_DEFAULT

#define PIN_TEMP_OK_LED PIO_PA1_IDX
#define PIN_TEMP_OK_LED_FLAGS PIO_OUTPUT_1 | PIO_DEFAULT

#define PIN_FPGA_PWR_ENABLE PIO_PB27_IDX
#define PIN_FPGA_PWR_ENABLE_FLAGS PIO_OUTPUT_0 | PIO_DEFAULT

#define PIN_SAM_SWITCHED_PWR_ENABLE PIO_PA4_IDX
#define PIN_SAM_SWITCHED_PWR_ENABLE_FLAGS PIO_OUTPUT_0 | PIO_DEFAULT

#define PIN_PGOOD_VCCINT PIO_PC16_IDX
#define PIN_PGOOD_VCCINT_FLAGS PIO_TYPE_PIO_INPUT | PIO_DEGLITCH | PIO_DEBOUNCE
#define PIN_PGOOD_VCCINT_PORT PIOC
#define PIN_PGOOD_VCCINT_PIN PIO_PC16

#define PIN_PGOOD_1V2 PIO_PC19_IDX
#define PIN_PGOOD_1V2_FLAGS PIO_TYPE_PIO_INPUT | PIO_DEFAULT
#define PIN_PGOOD_1V2_PORT PIOC
#define PIN_PGOOD_1V2_PIN PIO_PC19

#define PIN_PGOOD_1V8 PIO_PC20_IDX
#define PIN_PGOOD_1V8_FLAGS PIO_TYPE_PIO_INPUT | PIO_DEFAULT
#define PIN_PGOOD_1V8_PORT PIOC
#define PIN_PGOOD_1V8_PIN PIO_PC20

#define PIN_PGOOD_3V3 PIO_PB11_IDX
#define PIN_PGOOD_3V3_FLAGS PIO_TYPE_PIO_INPUT | PIO_DEFAULT
#define PIN_PGOOD_3V3_PORT PIOB
#define PIN_PGOOD_3V3_PIN PIO_PB11

#define PIN_SWSTATE_GPIO  PIO_PB26_IDX
#define PIN_SWSTATE_FLAGS  (PIO_TYPE_PIO_INPUT | PIO_DEFAULT)
#define board_get_powerstate()  gpio_pin_is_high(PIO_PB26_IDX)

#define FPGA_TRIGGER_GPIO PIO_PC13_IDX
#define FPGA_TRIGGER_FLAGS PIO_OUTPUT_0 | PIO_DEFAULT

#define PIN_USB_HBEAT PIO_PA3_IDX
#define PIN_USB_HBEAT_FLAGS (PIO_TYPE_PIO_OUTPUT_1 | PIO_DEFAULT)

#define PIN_FPGA_POWER_RESET PIO_PB23_IDX
#define PIN_FPGA_POWER_RESET_FLAGS PIO_TYPE_PIO_INPUT | PIO_DEGLITCH | PIO_DEBOUNCE | PIO_PULLUP
#define PIN_FPGA_POWER_RESET_PORT PIOB
#define PIN_FPGA_POWER_RESET_PIN PIO_PB23

#define PIN_VBUS_DETECT       (PIO_PC15_IDX)
#define PIN_VBUS_DETECT_FLAGS (PIO_TYPE_PIO_INPUT | PIO_DEFAULT)

#endif /* CW305_PLUS_PINS_H_ */

#endif