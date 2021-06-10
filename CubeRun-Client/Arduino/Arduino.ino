int xVal, yVal, jumpVal;

void setup() { 
  Serial.begin(9600) ;
  pinMode(9,INPUT); 
  digitalWrite(9,HIGH); 
} 

void loop() { 
  xVal = analogRead(A0);  
  yVal = analogRead(A1);
  jumpVal = digitalRead(9);  

  Serial.print(xVal,DEC);
  Serial.print(",");
  Serial.print(yVal,DEC);
  Serial.print(",");
  Serial.print(!jumpVal); 
  Serial.print("\n");
}
