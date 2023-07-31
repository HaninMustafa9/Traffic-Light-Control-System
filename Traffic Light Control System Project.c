 #define wait 300
 #define SEG1 PORTD.B0
 #define SEG2 PORTD.B1
 #define SEG3 PORTD.B2
 #define SEG4 PORTD.B3
 #define RED1 PORTA.B0
 #define YELLOW1 PORTA.B1
 #define GREEN1 PORTA.B2
 #define RED2 PORTE.B0
 #define YELLOW2 PORTE.B1
 #define GREEN2 PORTE.B2

/* FUNCTION PROTOTYPE */
void Automatic_Mode();
void Manual_Mode();
void Auto_Manual();


char display[]={0x20,0x19,0x18,0x17,0x16,0x15,0x14,0x13,0x12,0x11,0x10,0x09,0x08,0x07,0x06,0x05,0x04,0x03,0x02,0x01};
char counter, manual_flag = 0;

void interrupt(){
            if (INTF_bit == 1){
              INTF_bit = 0; // Acknowledgement step
              manual_flag = 1;
            }
}

void main() {

         /*   PORT INTIALIZATION   */

     ADCON1=7;
     
     TRISC = TRISD = TRISA = TRISE = 0;
     TRISB = 0XFF;
     
     SEG1= SEG2 = SEG3 = SEG4 = 0;
     
       // FIRST TRAFFIC
     RED1 = 1;  
     YELLOW1 = 0;
     GREEN1 = 0;
     
     // SECOND STREET
     RED2 = 0;
     YELLOW2 = 0;
     GREEN2 = 1;

     /* INTERRUPT INTIALIZATION */
     GIE_bit = 1 ;
     INTE_bit = 1 ;
     NOT_RBPU_bit = 0;

     /*  CODE  */

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
        SEG1 = SEG2 = SEG3 = SEG4 = 0;
        if(manual_flag == 1){
                    manual_flag = 0;
                    Manual_Mode();
        }
    }
     SEG1 = SEG2 = SEG3 = SEG4 = 1;
}



void Automatic_Mode(){

   SEG1 = SEG2 = SEG3 = SEG4 = 1; 

   if(RED1 == 1){ 

                       AUTO1 :{  while (1){
                             for(counter = 0; counter < 20; counter++){
                                          RED1 = 1; // Red is on & street1 is closed
                                          YELLOW1 = GREEN1 = 0;
                                          RED2 = YELLOW2 = 0;
                                          GREEN2 = 1;   // Green is on   street2 is opened
                                          PORTC = display[counter];   // count down from 20 to 0
                                          Delay_ms(wait);
                                          Auto_Manual();
                                          if (GREEN1 == 1) goto AUTO2 ;

                             }

                             for(counter = 17; counter < 20; counter++){
                                         RED1 = 1;
                                         YELLOW1 = GREEN1 = 0;
                                         RED2 = GREEN2 = 0;
                                         YELLOW2 = 1;    // Red is still on & Yellow is on street1 is closed & street2 is ready
                                         PORTC = display[counter]; // count down from 3 to 0
                                         Delay_ms(wait);
                                         Auto_Manual();
                                         if (GREEN1 == 1) goto AUTO2;
                              }
                              
                              for(counter=8;counter<20;counter++){
                                         RED1 = YELLOW1 = 0;
                                         GREEN1 = 1;  // Green is on   street1 is opened
                                         RED2 = 1;   // Red is on    street2 is closed
                                         GREEN2 = YELLOW2 = 0;
                                         PORTC = display[counter];  // Count down from 12 to 0
                                         Delay_ms(wait);
                                         Auto_Manual();
                                         if (RED1 == 1) goto AUTO1 ;
                              }
                              
                              for(counter=17;counter<20;counter++){
                                         RED1 = GREEN1 = 0;
                                         YELLOW1 = 1;   //Red is still on & Yellow is on   street2 is closed & street1 is ready
                                         RED2 =1;
                                         GREEN2 = YELLOW2 = 0;
                                         PORTC = display[counter];   // Count down from 3 to 0
                                         Delay_ms(wait);
                                         Auto_Manual();
                                         if (GREEN1 == 1) goto AUTO2;
                              }
                              }
            }
            }
            
   else if (GREEN1 == 1) { 

                         AUTO2:{  while (1){

                                for(counter = 0; counter < 20; counter++){
                                            GREEN1 = 1; // Green is on & street1 is opened
                                            YELLOW1 = RED1 = 0;
                                            GREEN2 = YELLOW2 = 0;
                                            RED2 = 1;   // Red is on & street2 is Closed
                                            PORTC = display[counter];   // count down from 20 to 0
                                            Delay_ms(wait);
                                            Auto_Manual();
                                            if (RED1 == 1) goto AUTO1;
                                 }

                                 for(counter = 17; counter < 20; counter++){
                                              YELLOW1 = 1;
                                              RED1 = GREEN1 = 0;
                                              YELLOW2 = GREEN2 = 0;
                                              RED2 = 1;    // Red is still on & Yellow is on. street2 is closed street1 is ready
                                              PORTC = display[counter]; // count down from 3 to 0
                                              Delay_ms(wait);
                                              Auto_Manual();
                                              if (RED1 == 1) goto AUTO1;
                                 }
                                 for(counter=8;counter<20;counter++){
                                             GREEN1 = YELLOW1 = 0;
                                             RED1 = 1;   // Red is on    street1 is closed
                                             GREEN2 = 1;  // Green is on   street2 is opened
                                             RED2 = YELLOW2 = 0;
                                             PORTC = display[counter];  // Count down from 12 to 0
                                             Delay_ms(wait);
                                             Auto_Manual();
                                             if (GREEN1 == 1) goto AUTO2;
                                }
                                for(counter=17;counter<20;counter++){
                                            YELLOW1 = GREEN1 = 0;
                                            RED1 = 1;   //Red is still on & Yellow is on  street1 is closed & street2 is ready
                                            YELLOW2 =1;
                                            GREEN2 = RED2 = 0;
                                            PORTC = display[counter];   // Count down from 3 to 0
                                            Delay_ms(wait);
                                            Auto_Manual();
                                            if (RED2 == 1) goto AUTO1;
                               }
                         }

                      }  
   }  
}



void Manual_Mode(){
                      if(RED1 == 1 || GREEN2 ==  1){
                         SEG1 = SEG2 = 0;
                         SEG3 = SEG4 = 1;
                          for(counter = 17; counter < 20; counter++){
                             RED2 = GREEN2 = 0;
                             YELLOW2 = 1;
                             PORTC = display[counter]; //countdown from 3 to 0
                             Delay_ms(wait);
                      }
                           RED1 = YELLOW1 = 0;
                           GREEN1 = 1;
                           GREEN2 = YELLOW2 = 0;
                           RED2 = 1;

                      }
                      else if(GREEN1 == 1 || RED2 == 1){
                          SEG1 = SEG2 = 1;
                          SEG3 = SEG4 = 0;
                          for(counter = 17; counter < 20; counter++){
                               RED1 = GREEN1 = 0;
                               YELLOW1 = 1;
                               YELLOW2 = GREEN2 = 0;
                               RED2 = 1;
                               PORTC = display[counter];
                               Delay_ms(wait);
                          }
                          RED1 = 1;
                          GREEN1 = YELLOW1 = 0;
                          RED2 = YELLOW2 = 0;
                          GREEN2 = 1;
                      }
}