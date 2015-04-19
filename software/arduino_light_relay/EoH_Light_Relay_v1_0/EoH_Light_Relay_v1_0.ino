//BLE Light Control for Eye of Horus interface

const byte pin_relay = 13;

String sp_read()
{
  String serialLine = "";
  while (Serial.available() >0)  
  {
    serialLine = serialLine + char(Serial.read());
  }
  return serialLine;
}

void setup()
{
  pinMode (pin_relay, OUTPUT); //Relay
  digitalWrite(pin_relay,LOW);
  
  Serial.begin(57600);
  delay(2000);
}

void loop()
{ 
  String msg = sp_read();

  if(msg.indexOf("light_on") >= 0)
  {
    digitalWrite(pin_relay,HIGH);
    Serial.println("relay_on");
    delay(50);
  }
  else if(msg.indexOf("light_off") >= 0)
  {
    digitalWrite(pin_relay,LOW);
    Serial.println("relay_off");
    delay(50);
  }
  // Es necesario para que lea bien el puerto
  delay(100);
}

