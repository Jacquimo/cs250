#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>
#include <wiringPi.h>
#include <wiringPiSPI.h>

#include "adc.h"

int main(int argc, char **argv){
	/*WiringPi Setup - for GPIOs*/
	if(wiringPiSetup() == -1)
		return 1; /*exit with error*/	
	
	/*WiringPi SPI Setup - for MCP3008*/
	if(init() < 0)
		return 1; /*exit with error*/

	int chan = 0;

	if(argc > 1)
		chan = atoi(argv[1]);

	pinMode(29, OUTPUT);

	while(1){
		
		/********** Do not change **********/
		int reading = readADC(chan);
		reading *= 100;
		reading /= 1023;
		
		fprintf(stderr, "%d\n", reading);
		/***********************************/


		/*Write your code here */
		if (reading == 0) {
		  digitalWrite(29, LOW);
		}
		else {
		  digitalWrite(29, HIGH);
		}
		

		delay(100);	
	}
	return 0; /*exit without errors*/
}
