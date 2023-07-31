#line 1 "C:/Courses & Projects/Training Embedded/Traffic Light Control System Project/Code/Traffic Light Control System Project.c"
#line 14 "C:/Courses & Projects/Training Embedded/Traffic Light Control System Project/Code/Traffic Light Control System Project.c"
void Automatic_Mode();
void Manual_Mode();
void Auto_Manual();


char display[]={0x20,0x19,0x18,0x17,0x16,0x15,0x14,0x13,0x12,0x11,0x10,0x09,0x08,0x07,0x06,0x05,0x04,0x03,0x02,0x01};
char counter, manual_flag = 0;

void interrupt(){
 if (INTF_bit == 1){
 INTF_bit = 0;
 manual_flag = 1;
 }
}

void main() {



 ADCON1=7;

 TRISC = TRISD = TRISA = TRISE = 0;
 TRISB = 0XFF;

  PORTD.B0 =  PORTD.B1  =  PORTD.B2  =  PORTD.B3  = 0;


  PORTA.B0  = 1;
  PORTA.B1  = 0;
  PORTA.B2  = 0;


  PORTE.B0  = 0;
  PORTE.B1  = 0;
  PORTE.B2  = 1;


 GIE_bit = 1 ;
 INTE_bit = 1 ;
 NOT_RBPU_bit = 0;



 while(1){
 if (PORTB.B1 == 0){
 Automatic_Mode();
 }
 else {
 if(manual_flag == 1){
 manual_flag = 0;
 Manual_Mode();
 }
 }

}
}



void Auto_Manual(){

 while (PORTB.B1 == 1) {
  PORTD.B0  =  PORTD.B1  =  PORTD.B2  =  PORTD.B3  = 0;
 if(manual_flag == 1){
 manual_flag = 0;
 Manual_Mode();
 }
 }
  PORTD.B0  =  PORTD.B1  =  PORTD.B2  =  PORTD.B3  = 1;
}



void Automatic_Mode(){

  PORTD.B0  =  PORTD.B1  =  PORTD.B2  =  PORTD.B3  = 1;

 if( PORTA.B0  == 1){

 AUTO1 :{ while (1){
 for(counter = 0; counter < 20; counter++){
  PORTA.B0  = 1;
  PORTA.B1  =  PORTA.B2  = 0;
  PORTE.B0  =  PORTE.B1  = 0;
  PORTE.B2  = 1;
 PORTC = display[counter];
 Delay_ms( 300 );
 Auto_Manual();
 if ( PORTA.B2  == 1) goto AUTO2 ;

 }

 for(counter = 17; counter < 20; counter++){
  PORTA.B0  = 1;
  PORTA.B1  =  PORTA.B2  = 0;
  PORTE.B0  =  PORTE.B2  = 0;
  PORTE.B1  = 1;
 PORTC = display[counter];
 Delay_ms( 300 );
 Auto_Manual();
 if ( PORTA.B2  == 1) goto AUTO2;
 }

 for(counter=8;counter<20;counter++){
  PORTA.B0  =  PORTA.B1  = 0;
  PORTA.B2  = 1;
  PORTE.B0  = 1;
  PORTE.B2  =  PORTE.B1  = 0;
 PORTC = display[counter];
 Delay_ms( 300 );
 Auto_Manual();
 if ( PORTA.B0  == 1) goto AUTO1 ;
 }

 for(counter=17;counter<20;counter++){
  PORTA.B0  =  PORTA.B2  = 0;
  PORTA.B1  = 1;
  PORTE.B0  =1;
  PORTE.B2  =  PORTE.B1  = 0;
 PORTC = display[counter];
 Delay_ms( 300 );
 Auto_Manual();
 if ( PORTA.B2  == 1) goto AUTO2;
 }
 }
 }
 }

 else if ( PORTA.B2  == 1) {

 AUTO2:{ while (1){

 for(counter = 0; counter < 20; counter++){
  PORTA.B2  = 1;
  PORTA.B1  =  PORTA.B0  = 0;
  PORTE.B2  =  PORTE.B1  = 0;
  PORTE.B0  = 1;
 PORTC = display[counter];
 Delay_ms( 300 );
 Auto_Manual();
 if ( PORTA.B0  == 1) goto AUTO1;
 }

 for(counter = 17; counter < 20; counter++){
  PORTA.B1  = 1;
  PORTA.B0  =  PORTA.B2  = 0;
  PORTE.B1  =  PORTE.B2  = 0;
  PORTE.B0  = 1;
 PORTC = display[counter];
 Delay_ms( 300 );
 Auto_Manual();
 if ( PORTA.B0  == 1) goto AUTO1;
 }
 for(counter=8;counter<20;counter++){
  PORTA.B2  =  PORTA.B1  = 0;
  PORTA.B0  = 1;
  PORTE.B2  = 1;
  PORTE.B0  =  PORTE.B1  = 0;
 PORTC = display[counter];
 Delay_ms( 300 );
 Auto_Manual();
 if ( PORTA.B2  == 1) goto AUTO2;
 }
 for(counter=17;counter<20;counter++){
  PORTA.B1  =  PORTA.B2  = 0;
  PORTA.B0  = 1;
  PORTE.B1  =1;
  PORTE.B2  =  PORTE.B0  = 0;
 PORTC = display[counter];
 Delay_ms( 300 );
 Auto_Manual();
 if ( PORTE.B0  == 1) goto AUTO1;
 }
 }

 }
 }
}



void Manual_Mode(){
 if( PORTA.B0  == 1 ||  PORTE.B2  == 1){
  PORTD.B0  =  PORTD.B1  = 0;
  PORTD.B2  =  PORTD.B3  = 1;
 for(counter = 17; counter < 20; counter++){
  PORTE.B0  =  PORTE.B2  = 0;
  PORTE.B1  = 1;
 PORTC = display[counter];
 Delay_ms( 300 );
 }
  PORTA.B0  =  PORTA.B1  = 0;
  PORTA.B2  = 1;
  PORTE.B2  =  PORTE.B1  = 0;
  PORTE.B0  = 1;

 }
 else if( PORTA.B2  == 1 ||  PORTE.B0  == 1){
  PORTD.B0  =  PORTD.B1  = 1;
  PORTD.B2  =  PORTD.B3  = 0;
 for(counter = 17; counter < 20; counter++){
  PORTA.B0  =  PORTA.B2  = 0;
  PORTA.B1  = 1;
  PORTE.B1  =  PORTE.B2  = 0;
  PORTE.B0  = 1;
 PORTC = display[counter];
 Delay_ms( 300 );
 }
  PORTA.B0  = 1;
  PORTA.B2  =  PORTA.B1  = 0;
  PORTE.B0  =  PORTE.B1  = 0;
  PORTE.B2  = 1;
 }
}
