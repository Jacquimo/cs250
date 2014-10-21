#include <stdio.h>
#include <wiringPi.h>
#include <softPwm.h>

/* Set Pin Numbers */
#define RED 29
#define GREEN 25
#define BLUE 28
#define INC 24
#define DEC 27
#define SETR 3
#define SETG 22
#define SETB 26

int main(void) {
	if (wiringPiSetup() == -1)
		return 1;

	/* Set GPIO Output Pins */
	pinMode(RED, OUTPUT);
	pinMode(GREEN, OUTPUT);
	pinMode(BLUE, OUTPUT);

	/* Set GPIO Input Pins */
	pinMode(INC, INPUT);
	pinMode(DEC, INPUT);
	pinMode(SETR, INPUT);
	pinMode(SETG, INPUT);
	pinMode(SETB, INPUT);

	/* Setup the software controlled PWM Pins */
	softPwmCreate(RED, 0, 100);
	softPwmCreate(GREEN, 0, 100);
	softPwmCreate(BLUE, 0, 100);

	/* Setup tracker variables */
	/* Track which colors to increase/decrease. > 0 means "on" */
	/*int redOn = -1;
	int greenOn = -1;
	int blueOn = -1;*/

	/* Maintain value to write to the LED's */
	int redVal = 0;
	int greenVal = 0;
	int blueVal = 0;
	const int updateFactor = 5; // Every modulation change will be +/- 5

	while(1) {
		// Check for if a set color button was pressed
		/*if (digitalRead(SETR))
			redOn *= -1;
		if (digitalRead(SETG))
			greenOn *= -1;
		if (digitalRead(SETB))
			blueOn *= -1;*/

		// Set the effect of pressing increase or decrease
		int change = 0;
		if (digitalRead(INC)) // Increase button pressed
			change = 1;
		else if (digitalRead(DEC)) // Decrease button pressed
			change = -1;
		// How much we will increment or decrement an LED, if we 
		// change anything at all
		change *= updateFactor;

		// Update the light values
		//if (redOn > 0) {
		if (digitalRead(SETR)) {
			redVal += change;
			if (redVal < 0) redVal = 0;
			else if (redVal > 100) redVal = 100;
		}
		//if (greenOn > 0) {
		if (digitalRead(SETG)) {
			greenVal += change;
			if (greenVal < 0) greenVal = 0;
			else if (greenVal > 100) greenVal = 100;
		}
		//if (blueOn > 0) {
		if (digitalRead(SETB)) {
			blueVal += change;
			if (blueVal < 0) blueVal = 0;
			else if (blueVal > 100) blueVal = 100;
		}

		//printf("%d\t%d\t%d\n", redOn, greenOn, blueOn);

		// Set the LED's to the (potentially) new values
		softPwmWrite(RED, redVal);
		softPwmWrite(GREEN, greenVal);
		softPwmWrite(BLUE, blueVal);


		delay(100);
	}	

	return 0;
}
