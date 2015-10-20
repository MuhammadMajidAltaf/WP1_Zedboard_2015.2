
/*****************************************************************************/
/**
* @file xspi_init_ADC.c
**
* @note
*
* None.
*
* MODIFICATION HISTORY:
*
* Ver   Who  Date     Changes
* ----- ---- -------- -----------------------------------------------
*
******************************************************************************/

/***************************** Include Files *********************************/

#include "xparameters.h"  /* EDK generated parameters */
#include "xspips.h"       /* SPI device driver */
#include "xil_printf.h"

/***************** Macros (Inline Functions) Definitions *********************/

XSpiPs Spi;

#define SPI_SELECT_ADC0 0x06
#define SPI_SELECT_ADC1 0x05
#define SPI_SELECT_ADC3 0x03				// non usato

#define read_buffer_size 10                 // size of the SPI read buffer
#define write_buffer_size 10                // size of the SPI write buffer
u8 ReadBuffer[read_buffer_size]   = {0x00}; // SPI read buffer initialize to 0
u8 WriteBuffer[write_buffer_size] = {0x00}; // SPI write buffer initialize to 0

int SpiPs_Init_SPI(u16 SpiDeviceId)
{
  int Status;
  XSpiPs_Config *SpiConfig;
/* Initialize the SPI driver so that it's ready to use */
  SpiConfig = XSpiPs_LookupConfig(SpiDeviceId);
  if (NULL == SpiConfig) { return XST_FAILURE; }
  Status = XSpiPs_CfgInitialize(&Spi, SpiConfig, SpiConfig->BaseAddress);
  if (Status != XST_SUCCESS) { return XST_FAILURE; }

  // Perform a self-test to check hardware build
  Status = XSpiPs_SelfTest(&Spi);
  if (Status != XST_SUCCESS) { return XST_FAILURE; }

// Set the SCLK frequency to SPI_REF_CLK / XSPIPS_CLK_PRESCALE_xx
  XSpiPs_SetClkPrescaler(&Spi, XSPIPS_CLK_PRESCALE_32);
// Set the Spi device as a master ( is slave by default).
  XSpiPs_SetOptions(&Spi, XSPIPS_MASTER_OPTION |
		                  XSPIPS_FORCE_SSELECT_OPTION |
		                  XSPIPS_DECODE_SSELECT_OPTION);

// ID request to adc
    WriteBuffer[0] = 0x80;
    WriteBuffer[1] = 0x01;
    WriteBuffer[2] = 0x00;
    XSpiPs_SetSlaveSelect(&Spi, SPI_SELECT_ADC0);
    XSpiPs_PolledTransfer(&Spi, WriteBuffer, ReadBuffer, 3);
    Status = ReadBuffer[2];


//************************************************
// Initialize The ADC component
//************************************************
// RESET
WriteBuffer[0] = 0x00;                            // writing cycle
WriteBuffer[1] = 0x00;                            // address register
WriteBuffer[2] = 0x3C;	// RESET
XSpiPs_SetSlaveSelect(&Spi, SPI_SELECT_ADC0);     // Assert the chip select
XSpiPs_PolledTransfer(&Spi, WriteBuffer, ReadBuffer, 3);


// Write config data into ADC0 Chip
  WriteBuffer[0] = 0x00;                            // writing cycle
  WriteBuffer[1] = 0x14;                            // address register
  WriteBuffer[2] = 0xA0;	// LVDS interleave
//  WriteBuffer[2] = 0xA4;	// LVDS interleave and channel input inverted
  XSpiPs_SetSlaveSelect(&Spi, SPI_SELECT_ADC0);     // Assert the chip select
  XSpiPs_PolledTransfer(&Spi, WriteBuffer, ReadBuffer, 3);

//  VREF setting
    	  WriteBuffer[0] = 0x00;
    	  WriteBuffer[1] = 0x18;
    	  WriteBuffer[2] = 0x04;	//2V
    	  XSpiPs_SetSlaveSelect(&Spi, SPI_SELECT_ADC0);     // Assert the chip select
    	  XSpiPs_PolledTransfer(&Spi, WriteBuffer, ReadBuffer, 3);

// Write delay command
//    WriteBuffer[0] = 0x00;                            // writing cycle
//    WriteBuffer[1] = 0x17;                            // address register
//    WriteBuffer[2] = 0x20;	// data delay 0.56ns
//    WriteBuffer[2] = 0x21;	// data delay 1.12ns
//    WriteBuffer[2] = 0x22;	// data delay 1.68ns
//    WriteBuffer[2] = 0x23;	// data delay 2.24ns
//    WriteBuffer[2] = 0x24;	// data delay 2.80ns
//    WriteBuffer[2] = 0x25;	// data delay 3.36ns
//    WriteBuffer[2] = 0x86;	// data delay 3.92ns
//    WriteBuffer[2] = 0x27;	// data delay 4.48ns

//    XSpiPs_SetSlaveSelect(&Spi, SPI_SELECT_ADC0);     // Assert the chip select
//    XSpiPs_PolledTransfer(&Spi, WriteBuffer, ReadBuffer, 3);
/*
// settaggio primo test pattern - bit LSB ad adc0
     	 	 WriteBuffer[0] = 0x00;
     	 	 WriteBuffer[1] = 0x19;
     	 	 WriteBuffer[2] = 0xCD;		// out definito
     	 	 XSpiPs_SetSlaveSelect(&Spi, SPI_SELECT_ADC0);
     	 	 XSpiPs_PolledTransfer(&Spi, WriteBuffer, ReadBuffer, 3);

// settaggio primo test pattern - bit MSB ad adc0
          	  WriteBuffer[0] = 0x00;
          	  WriteBuffer[1] = 0x1A;
          	  WriteBuffer[2] = 0xAB;		// out definito
          	  XSpiPs_SetSlaveSelect(&Spi, SPI_SELECT_ADC0);
          	  XSpiPs_PolledTransfer(&Spi, WriteBuffer, ReadBuffer, 3);

// settaggio secondo test pattern - bit LSB ad adc0
               WriteBuffer[0] = 0x00;
               WriteBuffer[1] = 0x1B;
               WriteBuffer[2] = 0xFF;		// out definito
               XSpiPs_SetSlaveSelect(&Spi, SPI_SELECT_ADC0);
               XSpiPs_PolledTransfer(&Spi, WriteBuffer, ReadBuffer, 3);

// settaggio secondo test pattern - bit MSB ad adc0
                    WriteBuffer[0] = 0x00;
                    WriteBuffer[1] = 0x1C;
                    WriteBuffer[2] = 0xFF;		// out definito
                    XSpiPs_SetSlaveSelect(&Spi, SPI_SELECT_ADC0);
                    XSpiPs_PolledTransfer(&Spi, WriteBuffer, ReadBuffer, 3);

// comando per determinare quale canale ricevera' il prossimo comando cha o chb
                    WriteBuffer[0] = 0x00;
                    WriteBuffer[1] = 0x05;
//                    WriteBuffer[2] = 0x01;		// CHA
                    WriteBuffer[2] = 0x02;		// CHB
//                    WriteBuffer[2] = 0x03;		// CHA e CHB
                    XSpiPs_SetSlaveSelect(&Spi, SPI_SELECT_ADC0);
                    XSpiPs_PolledTransfer(&Spi, WriteBuffer, ReadBuffer, 3);


                    WriteBuffer[0] = 0x00;
                    WriteBuffer[2] = 0xFF;
                    WriteBuffer[3] = 0x01;
                    XSpiPs_SetSlaveSelect(&Spi, SPI_SELECT_ADC1);
                    XSpiPs_PolledTransfer(&Spi, WriteBuffer, ReadBuffer, 3);
*/

          // settaggio test mode
          WriteBuffer[0] = 0x00;
          WriteBuffer[1] = 0x0D;
//          WriteBuffer[2] = 0x48;		// alternate continuous/repeat
        WriteBuffer[2] = 0x5F; // ramp
//           WriteBuffer[2] = 0x44; // uscita AAA 555
//           WriteBuffer[2] = 0x01; //  midscale
//            WriteBuffer[2] = 0x00; //	normal analog operation
          XSpiPs_SetSlaveSelect(&Spi, SPI_SELECT_ADC0);
          XSpiPs_PolledTransfer(&Spi, WriteBuffer, ReadBuffer, 3);

return Status;
//  return XST_SUCCESS;
}

