/**
*  LED CONTROLLER for Auger Experiment
*  written from Roberto Assiro May 2015
* rouutine per generare impulso su JE9
/***************************** Include Files **********************************/
#include "xparameters.h"
#include "xgpiops.h"
#include "xstatus.h"
#include <xil_printf.h>
#define GPIO_DEVICE_ID  	XPAR_XGPIOPS_0_DEVICE_ID

#define PULSE_DELAY		100
#define OUTPUT_PIN		9	/* Pin connected to zedboard Output connector*/
#define LED_MAX_PULSE		0x1	/* Number of times the PULSE  */
#define printf			xil_printf	/* Smalller foot-print printf */

static int GpioOutputExample(void);
int GpioPolledExample(u16 DeviceId, u32 *DataRead);

XGpioPs Gpio;	/* The driver instance for GPIO Device. */
u32 InputData;

int GpioPolledExample(u16 DeviceId, u32 *DataRead)
{
/**/	int Status;
	XGpioPs_Config *ConfigPtr;
	ConfigPtr = XGpioPs_LookupConfig(GPIO_DEVICE_ID);
	Status = XGpioPs_CfgInitialize(&Gpio, ConfigPtr, ConfigPtr->BaseAddr);
	if (Status != XST_SUCCESS) {
		return XST_FAILURE;
	}



	Status = GpioOutputExample();
	if (Status != XST_SUCCESS) {
		return XST_FAILURE;
	}
	return XST_SUCCESS;
}


static int GpioOutputExample(void)
{
	u32 Data;
	volatile int Delay;
	u32 LedLoop;
	XGpioPs_SetDirectionPin(&Gpio, OUTPUT_PIN, 1);
	XGpioPs_SetOutputEnablePin(&Gpio, OUTPUT_PIN, 1);

	XGpioPs_WritePin(&Gpio, OUTPUT_PIN, 0x0);
	for (LedLoop = 0; LedLoop < LED_MAX_PULSE; LedLoop ++) {
#ifndef __SIM__

		for (Delay = 0; Delay < PULSE_DELAY; Delay++);
#endif

		XGpioPs_WritePin(&Gpio, OUTPUT_PIN, 0x1);   //Set the GPIO Output to High

		Data = XGpioPs_ReadPin(&Gpio, OUTPUT_PIN);
		if (Data != 1 ) {
			return XST_FAILURE;
		}

#ifndef __SIM__

		for (Delay = 0; Delay < PULSE_DELAY; Delay++);

#endif

		XGpioPs_WritePin(&Gpio, OUTPUT_PIN, 0x0);	//Clear the GPIO Output.

	}
	return XST_SUCCESS;
}





