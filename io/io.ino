
// INCLUDE MASSAGE
#include <AsciiMassagePacker.h>

// PACKER(FOR SENDING) AND PARSER(FOR RECEIVING) INSTANCES.
AsciiMassagePacker outbound;
int i;
int j;

#define triggerThreshold 700
#define noHitFor 150
uint32_t lastHitHappened = 0;

///////////
// SETUP //
///////////
void setup() {

  // INITIATE SERIAL COMMUNICATION.
  Serial.begin(115200);

  for(i = 0; i < 13; i++) {
    pinMode(i, INPUT);
    digitalWrite(i, HIGH);
  }
}



//////////
// LOOP //
//////////
void loop() {
 
 /// Begins the sending of a message.
  outbound.beginPacket("tac");

  // Simple piezo drum trigger (on shoe)
  /*
  uint16_t value = analogRead(A5);
  if ((value >= triggerThreshold) && millis() > (lastHitHappened + noHitFor)) {
    lastHitHappened = millis();
    outbound.addInt(1);
  } else {
    outbound.addInt(0);
  }*/
  outbound.addInt(0);
  uint16_t tmode = digitalRead(0);
  outbound.addByte(tmode);
  //if(tmode) {
      outbound.addInt(analogRead(A0));
      outbound.addInt(analogRead(A1));
      outbound.addInt(analogRead(A2));
      outbound.addInt(analogRead(A3));
      outbound.addInt(analogRead(A4));
      for(i = 2; i < 14; i++) {
        outbound.addInt(digitalRead(i));
      }
    
   //}
   outbound.streamPacket(&Serial);
   Serial.flush();
}
