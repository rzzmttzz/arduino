/*

 */
 
//#define PWM0 0      // pin 5
//#define PWM1 1      // pin 6
//#define DIGITAL0 0  // pin 5
//#define DIGITAL1 1  // pin 6
//#define DIGITAL2 2  // pin 7
#define DIGITAL3 3  // pin 2
//#define DIGITAL4 4  // pin 3
//#define DIGITAL5 5  // pin 1
//#define ADC0 0      // pin 1
#define ADC1 1      // pin 7
#define ADC2 2      // pin 3
//#define ADC3 3      // pin 2

//#define VCC 8       // pin 8 (2.7 - 5.5V)
//#define GND 4       // pin 4

void setup() {                
  // initialize the digital pin as an output.
  // Pin 13 has an LED connected on most Arduino boards:
  pinMode(DIGITAL3, OUTPUT); 
  //pinMode(PWM0, OUTPUT); 

  ADCSRA |= (1 << ADEN)| // Analog-Digital enable bit
  (1 << ADPS1)| // set prescaler to 8 (clock / 8)
  (1 << ADPS0); // set prescaler to 8 (clock / 8)
}

void loop() {
  int a = realAnalogRead(ADC2);
  int b = realAnalogRead(ADC1);
  //
  //a = a==0?1:a;
  //int a=512;
  //int b=512;
  int duty = b/(1023/100);
  //int duty = b/11;
  
  //int pwm = a/4;
  //analogWrite(PWM0, pwm);
  
  digitalWrite(DIGITAL3, HIGH);
  delay(a*duty/100);
  digitalWrite(DIGITAL3, LOW);
  delay(a*(100-duty)/100);
}

// Select ADC Channel ch must be 0-7
int realAnalogRead(uint8_t ch) {
 ADMUX = (1 << ADLAR)| // AD result store in (more significant bit in ADCH)
   ch&0b00000111; // switch to adc channel
 
 ADCSRA |= (1 << ADEN)| // Analog-Digital enable bit
   (1 << ADSC); // Discard first conversion
 
 while (ADCSRA & (1 << ADSC)); // wait until conversion is done
 
 ADCSRA |= (1 << ADSC); // start single conversion
 
 while (ADCSRA & (1 << ADSC)) // wait until conversion is done
 
 ADCSRA &= ~(1<<ADEN); // shut down the ADC
 
 return ADCH;
}

