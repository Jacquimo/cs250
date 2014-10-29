#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>
#include <wiringPi.h>
#include <wiringPiSPI.h>

#include "adc.h"
#define FIRST 29
#define SECOND 3
#define THIRD 25
#define FOURTH 28

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

	pinMode(FIRST, OUTPUT);
	pinMode(SECOND, OUTPUT);
	pinMode(THIRD, OUTPUT);
	pinMode(FOURTH, OUTPUT);

	while(1){
		
		/********** Do not change **********/
		int reading = readADC(chan);
		reading *= 100;
		reading /= 1023;
		
		fprintf(stderr, "%d\n", reading);
		/***********************************/


		/*Write your code here */
		/*if (reading == 0) {
		  digitalWrite(29, LOW);

		}
		elswe {
		  digitalWrite(29, HIGH);
		  
		  }*/

		if (reading > 75)
		  digitalWrite(FOURTH, HIGH);
		else
		  digitalWrite(FOURTH, LOW);

		if (reading > 50)
		  digitalWrite(THIRD, HIGH);
		else
		  digitalWrite(THIRD, LOW);

		if (reading > 25)
		  digitalWrite(SECOND, HIGH);
		else
		  digitalWrite(SECOND, LOW);

		if (reading > 0)
		  digitalWrite(FIRST, HIGH);
		else
		  digitalWrite(FIRST, LOW);


		delay(100);	
	}

	// If we somehow exit the loop, turn off all the lights
	digitalWrite(FIRST, LOW);
	digitalWrite(SECOND, LOW);
	digitalWrite(THIRD, LOW);
	digitalWrite(FOURTH, LOW);

	return 0; /*exit without errors*/
}
