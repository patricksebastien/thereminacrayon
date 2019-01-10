
// INCLUDE MASSAGE
#include <AsciiMassagePacker.h>

// PACKER(FOR SENDING) AND PARSER(FOR RECEIVING) INSTANCES.
AsciiMassagePacker outbound;

// THIS VARIABLE IS USED TO SLOW DOWN THE SENDING OF THE MASSAGES.
unsigned long lastTimeMassageSent;
int i;
int j;

///////////
// SETUP //
///////////
void setup() {

  // INITIATE SERIAL COMMUNICATION.
  Serial.begin(57600);

  for(i = 0; i < 13; i++) {
    pinMode(i, INPUT);
    digitalWrite(i, HIGH);
  }
}



//////////
// LOOP //
//////////
void loop() {


  // SEND A PACKET EVERY 100 ms:
  if ( millis() - lastTimeMassageSent >= 100 ) {
    lastTimeMassageSent = millis();

    /// Begins the sending of a message.
    outbound.beginPacket("tac");
  
    /// Adds a byte.
    //outbound.addByte(45);
    /// Adds a long.
    //outbound.addLong(64823);
    /// Adds a float.
    //outbound.addFloat(183.92);
    outbound.addInt(analogRead(A0));
    outbound.addInt(analogRead(A1));
    outbound.addInt(analogRead(A2));
    outbound.addInt(analogRead(A3));
    outbound.addInt(analogRead(A4));
    outbound.addInt(digitalRead(0));
    for(i = 2; i < 14; i++) {
      outbound.addInt(digitalRead(i));
    }
    
    /// End and stream the massage packet:
    outbound.streamPacket(&Serial);
  }
 

}
