
_interrupt:
	MOVWF      R15+0
	SWAPF      STATUS+0, 0
	CLRF       STATUS+0
	MOVWF      ___saveSTATUS+0
	MOVF       PCLATH+0, 0
	MOVWF      ___savePCLATH+0
	CLRF       PCLATH+0

;Traffic Light Control System Project.c,22 :: 		void interrupt(){
;Traffic Light Control System Project.c,23 :: 		if (INTF_bit == 1){
	BTFSS      INTF_bit+0, BitPos(INTF_bit+0)
	GOTO       L_interrupt0
;Traffic Light Control System Project.c,24 :: 		INTF_bit = 0; // Acknowledgement step
	BCF        INTF_bit+0, BitPos(INTF_bit+0)
;Traffic Light Control System Project.c,25 :: 		manual_flag = 1;
	MOVLW      1
	MOVWF      _manual_flag+0
;Traffic Light Control System Project.c,26 :: 		}
L_interrupt0:
;Traffic Light Control System Project.c,27 :: 		}
L_end_interrupt:
L__interrupt74:
	MOVF       ___savePCLATH+0, 0
	MOVWF      PCLATH+0
	SWAPF      ___saveSTATUS+0, 0
	MOVWF      STATUS+0
	SWAPF      R15+0, 1
	SWAPF      R15+0, 0
	RETFIE
; end of _interrupt

_main:

;Traffic Light Control System Project.c,29 :: 		void main() {
;Traffic Light Control System Project.c,33 :: 		ADCON1=7;
	MOVLW      7
	MOVWF      ADCON1+0
;Traffic Light Control System Project.c,35 :: 		TRISC = TRISD = TRISA = TRISE = 0;
	CLRF       TRISE+0
	MOVF       TRISE+0, 0
	MOVWF      TRISA+0
	MOVF       TRISA+0, 0
	MOVWF      TRISD+0
	MOVF       TRISD+0, 0
	MOVWF      TRISC+0
;Traffic Light Control System Project.c,36 :: 		TRISB = 0XFF;
	MOVLW      255
	MOVWF      TRISB+0
;Traffic Light Control System Project.c,38 :: 		SEG1= SEG2 = SEG3 = SEG4 = 0;
	BCF        PORTD+0, 3
	BTFSC      PORTD+0, 3
	GOTO       L__main76
	BCF        PORTD+0, 2
	GOTO       L__main77
L__main76:
	BSF        PORTD+0, 2
L__main77:
	BTFSC      PORTD+0, 2
	GOTO       L__main78
	BCF        PORTD+0, 1
	GOTO       L__main79
L__main78:
	BSF        PORTD+0, 1
L__main79:
	BTFSC      PORTD+0, 1
	GOTO       L__main80
	BCF        PORTD+0, 0
	GOTO       L__main81
L__main80:
	BSF        PORTD+0, 0
L__main81:
;Traffic Light Control System Project.c,41 :: 		RED1 = 1;
	BSF        PORTA+0, 0
;Traffic Light Control System Project.c,42 :: 		YELLOW1 = 0;
	BCF        PORTA+0, 1
;Traffic Light Control System Project.c,43 :: 		GREEN1 = 0;
	BCF        PORTA+0, 2
;Traffic Light Control System Project.c,46 :: 		RED2 = 0;
	BCF        PORTE+0, 0
;Traffic Light Control System Project.c,47 :: 		YELLOW2 = 0;
	BCF        PORTE+0, 1
;Traffic Light Control System Project.c,48 :: 		GREEN2 = 1;
	BSF        PORTE+0, 2
;Traffic Light Control System Project.c,51 :: 		GIE_bit = 1 ;
	BSF        GIE_bit+0, BitPos(GIE_bit+0)
;Traffic Light Control System Project.c,52 :: 		INTE_bit = 1 ;
	BSF        INTE_bit+0, BitPos(INTE_bit+0)
;Traffic Light Control System Project.c,53 :: 		NOT_RBPU_bit = 0;
	BCF        NOT_RBPU_bit+0, BitPos(NOT_RBPU_bit+0)
;Traffic Light Control System Project.c,57 :: 		while(1){
L_main1:
;Traffic Light Control System Project.c,58 :: 		if (PORTB.B1 == 0){
	BTFSC      PORTB+0, 1
	GOTO       L_main3
;Traffic Light Control System Project.c,59 :: 		Automatic_Mode();
	CALL       _Automatic_Mode+0
;Traffic Light Control System Project.c,60 :: 		}
	GOTO       L_main4
L_main3:
;Traffic Light Control System Project.c,62 :: 		if(manual_flag == 1){
	MOVF       _manual_flag+0, 0
	XORLW      1
	BTFSS      STATUS+0, 2
	GOTO       L_main5
;Traffic Light Control System Project.c,63 :: 		manual_flag = 0;
	CLRF       _manual_flag+0
;Traffic Light Control System Project.c,64 :: 		Manual_Mode();
	CALL       _Manual_Mode+0
;Traffic Light Control System Project.c,65 :: 		}
L_main5:
;Traffic Light Control System Project.c,66 :: 		}
L_main4:
;Traffic Light Control System Project.c,68 :: 		}
	GOTO       L_main1
;Traffic Light Control System Project.c,69 :: 		}
L_end_main:
	GOTO       $+0
; end of _main

_Auto_Manual:

;Traffic Light Control System Project.c,73 :: 		void Auto_Manual(){
;Traffic Light Control System Project.c,75 :: 		while (PORTB.B1 == 1) {
L_Auto_Manual6:
	BTFSS      PORTB+0, 1
	GOTO       L_Auto_Manual7
;Traffic Light Control System Project.c,76 :: 		SEG1 = SEG2 = SEG3 = SEG4 = 0;
	BCF        PORTD+0, 3
	BTFSC      PORTD+0, 3
	GOTO       L__Auto_Manual83
	BCF        PORTD+0, 2
	GOTO       L__Auto_Manual84
L__Auto_Manual83:
	BSF        PORTD+0, 2
L__Auto_Manual84:
	BTFSC      PORTD+0, 2
	GOTO       L__Auto_Manual85
	BCF        PORTD+0, 1
	GOTO       L__Auto_Manual86
L__Auto_Manual85:
	BSF        PORTD+0, 1
L__Auto_Manual86:
	BTFSC      PORTD+0, 1
	GOTO       L__Auto_Manual87
	BCF        PORTD+0, 0
	GOTO       L__Auto_Manual88
L__Auto_Manual87:
	BSF        PORTD+0, 0
L__Auto_Manual88:
;Traffic Light Control System Project.c,77 :: 		if(manual_flag == 1){
	MOVF       _manual_flag+0, 0
	XORLW      1
	BTFSS      STATUS+0, 2
	GOTO       L_Auto_Manual8
;Traffic Light Control System Project.c,78 :: 		manual_flag = 0;
	CLRF       _manual_flag+0
;Traffic Light Control System Project.c,79 :: 		Manual_Mode();
	CALL       _Manual_Mode+0
;Traffic Light Control System Project.c,80 :: 		}
L_Auto_Manual8:
;Traffic Light Control System Project.c,81 :: 		}
	GOTO       L_Auto_Manual6
L_Auto_Manual7:
;Traffic Light Control System Project.c,82 :: 		SEG1 = SEG2 = SEG3 = SEG4 = 1;
	BSF        PORTD+0, 3
	BTFSC      PORTD+0, 3
	GOTO       L__Auto_Manual89
	BCF        PORTD+0, 2
	GOTO       L__Auto_Manual90
L__Auto_Manual89:
	BSF        PORTD+0, 2
L__Auto_Manual90:
	BTFSC      PORTD+0, 2
	GOTO       L__Auto_Manual91
	BCF        PORTD+0, 1
	GOTO       L__Auto_Manual92
L__Auto_Manual91:
	BSF        PORTD+0, 1
L__Auto_Manual92:
	BTFSC      PORTD+0, 1
	GOTO       L__Auto_Manual93
	BCF        PORTD+0, 0
	GOTO       L__Auto_Manual94
L__Auto_Manual93:
	BSF        PORTD+0, 0
L__Auto_Manual94:
;Traffic Light Control System Project.c,83 :: 		}
L_end_Auto_Manual:
	RETURN
; end of _Auto_Manual

_Automatic_Mode:

;Traffic Light Control System Project.c,87 :: 		void Automatic_Mode(){
;Traffic Light Control System Project.c,89 :: 		SEG1 = SEG2 = SEG3 = SEG4 = 1;
	BSF        PORTD+0, 3
	BTFSC      PORTD+0, 3
	GOTO       L__Automatic_Mode96
	BCF        PORTD+0, 2
	GOTO       L__Automatic_Mode97
L__Automatic_Mode96:
	BSF        PORTD+0, 2
L__Automatic_Mode97:
	BTFSC      PORTD+0, 2
	GOTO       L__Automatic_Mode98
	BCF        PORTD+0, 1
	GOTO       L__Automatic_Mode99
L__Automatic_Mode98:
	BSF        PORTD+0, 1
L__Automatic_Mode99:
	BTFSC      PORTD+0, 1
	GOTO       L__Automatic_Mode100
	BCF        PORTD+0, 0
	GOTO       L__Automatic_Mode101
L__Automatic_Mode100:
	BSF        PORTD+0, 0
L__Automatic_Mode101:
;Traffic Light Control System Project.c,91 :: 		if(RED1 == 1){
	BTFSS      PORTA+0, 0
	GOTO       L_Automatic_Mode9
;Traffic Light Control System Project.c,93 :: 		AUTO1 :{  while (1){
___Automatic_Mode_AUTO1:
L_Automatic_Mode10:
;Traffic Light Control System Project.c,94 :: 		for(counter = 0; counter < 20; counter++){
	CLRF       _counter+0
L_Automatic_Mode12:
	MOVLW      20
	SUBWF      _counter+0, 0
	BTFSC      STATUS+0, 0
	GOTO       L_Automatic_Mode13
;Traffic Light Control System Project.c,95 :: 		RED1 = 1; // Red is on & street1 is closed
	BSF        PORTA+0, 0
;Traffic Light Control System Project.c,96 :: 		YELLOW1 = GREEN1 = 0;
	BCF        PORTA+0, 2
	BTFSC      PORTA+0, 2
	GOTO       L__Automatic_Mode102
	BCF        PORTA+0, 1
	GOTO       L__Automatic_Mode103
L__Automatic_Mode102:
	BSF        PORTA+0, 1
L__Automatic_Mode103:
;Traffic Light Control System Project.c,97 :: 		RED2 = YELLOW2 = 0;
	BCF        PORTE+0, 1
	BTFSC      PORTE+0, 1
	GOTO       L__Automatic_Mode104
	BCF        PORTE+0, 0
	GOTO       L__Automatic_Mode105
L__Automatic_Mode104:
	BSF        PORTE+0, 0
L__Automatic_Mode105:
;Traffic Light Control System Project.c,98 :: 		GREEN2 = 1;   // Green is on   street2 is opened
	BSF        PORTE+0, 2
;Traffic Light Control System Project.c,99 :: 		PORTC = display[counter];   // count down from 20 to 0
	MOVF       _counter+0, 0
	ADDLW      _display+0
	MOVWF      FSR
	MOVF       INDF+0, 0
	MOVWF      PORTC+0
;Traffic Light Control System Project.c,100 :: 		Delay_ms(wait);
	MOVLW      4
	MOVWF      R11+0
	MOVLW      12
	MOVWF      R12+0
	MOVLW      51
	MOVWF      R13+0
L_Automatic_Mode15:
	DECFSZ     R13+0, 1
	GOTO       L_Automatic_Mode15
	DECFSZ     R12+0, 1
	GOTO       L_Automatic_Mode15
	DECFSZ     R11+0, 1
	GOTO       L_Automatic_Mode15
	NOP
	NOP
;Traffic Light Control System Project.c,101 :: 		Auto_Manual();
	CALL       _Auto_Manual+0
;Traffic Light Control System Project.c,102 :: 		if (GREEN1 == 1) goto AUTO2 ;
	BTFSS      PORTA+0, 2
	GOTO       L_Automatic_Mode16
	GOTO       ___Automatic_Mode_AUTO2
L_Automatic_Mode16:
;Traffic Light Control System Project.c,94 :: 		for(counter = 0; counter < 20; counter++){
	INCF       _counter+0, 1
;Traffic Light Control System Project.c,104 :: 		}
	GOTO       L_Automatic_Mode12
L_Automatic_Mode13:
;Traffic Light Control System Project.c,106 :: 		for(counter = 17; counter < 20; counter++){
	MOVLW      17
	MOVWF      _counter+0
L_Automatic_Mode17:
	MOVLW      20
	SUBWF      _counter+0, 0
	BTFSC      STATUS+0, 0
	GOTO       L_Automatic_Mode18
;Traffic Light Control System Project.c,107 :: 		RED1 = 1;
	BSF        PORTA+0, 0
;Traffic Light Control System Project.c,108 :: 		YELLOW1 = GREEN1 = 0;
	BCF        PORTA+0, 2
	BTFSC      PORTA+0, 2
	GOTO       L__Automatic_Mode106
	BCF        PORTA+0, 1
	GOTO       L__Automatic_Mode107
L__Automatic_Mode106:
	BSF        PORTA+0, 1
L__Automatic_Mode107:
;Traffic Light Control System Project.c,109 :: 		RED2 = GREEN2 = 0;
	BCF        PORTE+0, 2
	BTFSC      PORTE+0, 2
	GOTO       L__Automatic_Mode108
	BCF        PORTE+0, 0
	GOTO       L__Automatic_Mode109
L__Automatic_Mode108:
	BSF        PORTE+0, 0
L__Automatic_Mode109:
;Traffic Light Control System Project.c,110 :: 		YELLOW2 = 1;    // Red is still on & Yellow is on street1 is closed & street2 is ready
	BSF        PORTE+0, 1
;Traffic Light Control System Project.c,111 :: 		PORTC = display[counter]; // count down from 3 to 0
	MOVF       _counter+0, 0
	ADDLW      _display+0
	MOVWF      FSR
	MOVF       INDF+0, 0
	MOVWF      PORTC+0
;Traffic Light Control System Project.c,112 :: 		Delay_ms(wait);
	MOVLW      4
	MOVWF      R11+0
	MOVLW      12
	MOVWF      R12+0
	MOVLW      51
	MOVWF      R13+0
L_Automatic_Mode20:
	DECFSZ     R13+0, 1
	GOTO       L_Automatic_Mode20
	DECFSZ     R12+0, 1
	GOTO       L_Automatic_Mode20
	DECFSZ     R11+0, 1
	GOTO       L_Automatic_Mode20
	NOP
	NOP
;Traffic Light Control System Project.c,113 :: 		Auto_Manual();
	CALL       _Auto_Manual+0
;Traffic Light Control System Project.c,114 :: 		if (GREEN1 == 1) goto AUTO2;
	BTFSS      PORTA+0, 2
	GOTO       L_Automatic_Mode21
	GOTO       ___Automatic_Mode_AUTO2
L_Automatic_Mode21:
;Traffic Light Control System Project.c,106 :: 		for(counter = 17; counter < 20; counter++){
	INCF       _counter+0, 1
;Traffic Light Control System Project.c,115 :: 		}
	GOTO       L_Automatic_Mode17
L_Automatic_Mode18:
;Traffic Light Control System Project.c,117 :: 		for(counter=8;counter<20;counter++){
	MOVLW      8
	MOVWF      _counter+0
L_Automatic_Mode22:
	MOVLW      20
	SUBWF      _counter+0, 0
	BTFSC      STATUS+0, 0
	GOTO       L_Automatic_Mode23
;Traffic Light Control System Project.c,118 :: 		RED1 = YELLOW1 = 0;
	BCF        PORTA+0, 1
	BTFSC      PORTA+0, 1
	GOTO       L__Automatic_Mode110
	BCF        PORTA+0, 0
	GOTO       L__Automatic_Mode111
L__Automatic_Mode110:
	BSF        PORTA+0, 0
L__Automatic_Mode111:
;Traffic Light Control System Project.c,119 :: 		GREEN1 = 1;  // Green is on   street1 is opened
	BSF        PORTA+0, 2
;Traffic Light Control System Project.c,120 :: 		RED2 = 1;   // Red is on    street2 is closed
	BSF        PORTE+0, 0
;Traffic Light Control System Project.c,121 :: 		GREEN2 = YELLOW2 = 0;
	BCF        PORTE+0, 1
	BTFSC      PORTE+0, 1
	GOTO       L__Automatic_Mode112
	BCF        PORTE+0, 2
	GOTO       L__Automatic_Mode113
L__Automatic_Mode112:
	BSF        PORTE+0, 2
L__Automatic_Mode113:
;Traffic Light Control System Project.c,122 :: 		PORTC = display[counter];  // Count down from 12 to 0
	MOVF       _counter+0, 0
	ADDLW      _display+0
	MOVWF      FSR
	MOVF       INDF+0, 0
	MOVWF      PORTC+0
;Traffic Light Control System Project.c,123 :: 		Delay_ms(wait);
	MOVLW      4
	MOVWF      R11+0
	MOVLW      12
	MOVWF      R12+0
	MOVLW      51
	MOVWF      R13+0
L_Automatic_Mode25:
	DECFSZ     R13+0, 1
	GOTO       L_Automatic_Mode25
	DECFSZ     R12+0, 1
	GOTO       L_Automatic_Mode25
	DECFSZ     R11+0, 1
	GOTO       L_Automatic_Mode25
	NOP
	NOP
;Traffic Light Control System Project.c,124 :: 		Auto_Manual();
	CALL       _Auto_Manual+0
;Traffic Light Control System Project.c,125 :: 		if (RED1 == 1) goto AUTO1 ;
	BTFSS      PORTA+0, 0
	GOTO       L_Automatic_Mode26
	GOTO       ___Automatic_Mode_AUTO1
L_Automatic_Mode26:
;Traffic Light Control System Project.c,117 :: 		for(counter=8;counter<20;counter++){
	INCF       _counter+0, 1
;Traffic Light Control System Project.c,126 :: 		}
	GOTO       L_Automatic_Mode22
L_Automatic_Mode23:
;Traffic Light Control System Project.c,128 :: 		for(counter=17;counter<20;counter++){
	MOVLW      17
	MOVWF      _counter+0
L_Automatic_Mode27:
	MOVLW      20
	SUBWF      _counter+0, 0
	BTFSC      STATUS+0, 0
	GOTO       L_Automatic_Mode28
;Traffic Light Control System Project.c,129 :: 		RED1 = GREEN1 = 0;
	BCF        PORTA+0, 2
	BTFSC      PORTA+0, 2
	GOTO       L__Automatic_Mode114
	BCF        PORTA+0, 0
	GOTO       L__Automatic_Mode115
L__Automatic_Mode114:
	BSF        PORTA+0, 0
L__Automatic_Mode115:
;Traffic Light Control System Project.c,130 :: 		YELLOW1 = 1;   //Red is still on & Yellow is on   street2 is closed & street1 is ready
	BSF        PORTA+0, 1
;Traffic Light Control System Project.c,131 :: 		RED2 =1;
	BSF        PORTE+0, 0
;Traffic Light Control System Project.c,132 :: 		GREEN2 = YELLOW2 = 0;
	BCF        PORTE+0, 1
	BTFSC      PORTE+0, 1
	GOTO       L__Automatic_Mode116
	BCF        PORTE+0, 2
	GOTO       L__Automatic_Mode117
L__Automatic_Mode116:
	BSF        PORTE+0, 2
L__Automatic_Mode117:
;Traffic Light Control System Project.c,133 :: 		PORTC = display[counter];   // Count down from 3 to 0
	MOVF       _counter+0, 0
	ADDLW      _display+0
	MOVWF      FSR
	MOVF       INDF+0, 0
	MOVWF      PORTC+0
;Traffic Light Control System Project.c,134 :: 		Delay_ms(wait);
	MOVLW      4
	MOVWF      R11+0
	MOVLW      12
	MOVWF      R12+0
	MOVLW      51
	MOVWF      R13+0
L_Automatic_Mode30:
	DECFSZ     R13+0, 1
	GOTO       L_Automatic_Mode30
	DECFSZ     R12+0, 1
	GOTO       L_Automatic_Mode30
	DECFSZ     R11+0, 1
	GOTO       L_Automatic_Mode30
	NOP
	NOP
;Traffic Light Control System Project.c,135 :: 		Auto_Manual();
	CALL       _Auto_Manual+0
;Traffic Light Control System Project.c,136 :: 		if (GREEN1 == 1) goto AUTO2;
	BTFSS      PORTA+0, 2
	GOTO       L_Automatic_Mode31
	GOTO       ___Automatic_Mode_AUTO2
L_Automatic_Mode31:
;Traffic Light Control System Project.c,128 :: 		for(counter=17;counter<20;counter++){
	INCF       _counter+0, 1
;Traffic Light Control System Project.c,137 :: 		}
	GOTO       L_Automatic_Mode27
L_Automatic_Mode28:
;Traffic Light Control System Project.c,138 :: 		}
	GOTO       L_Automatic_Mode10
;Traffic Light Control System Project.c,140 :: 		}
L_Automatic_Mode9:
;Traffic Light Control System Project.c,142 :: 		else if (GREEN1 == 1) {
	BTFSS      PORTA+0, 2
	GOTO       L_Automatic_Mode33
;Traffic Light Control System Project.c,144 :: 		AUTO2:{  while (1){
___Automatic_Mode_AUTO2:
L_Automatic_Mode34:
;Traffic Light Control System Project.c,146 :: 		for(counter = 0; counter < 20; counter++){
	CLRF       _counter+0
L_Automatic_Mode36:
	MOVLW      20
	SUBWF      _counter+0, 0
	BTFSC      STATUS+0, 0
	GOTO       L_Automatic_Mode37
;Traffic Light Control System Project.c,147 :: 		GREEN1 = 1; // Green is on & street1 is opened
	BSF        PORTA+0, 2
;Traffic Light Control System Project.c,148 :: 		YELLOW1 = RED1 = 0;
	BCF        PORTA+0, 0
	BTFSC      PORTA+0, 0
	GOTO       L__Automatic_Mode118
	BCF        PORTA+0, 1
	GOTO       L__Automatic_Mode119
L__Automatic_Mode118:
	BSF        PORTA+0, 1
L__Automatic_Mode119:
;Traffic Light Control System Project.c,149 :: 		GREEN2 = YELLOW2 = 0;
	BCF        PORTE+0, 1
	BTFSC      PORTE+0, 1
	GOTO       L__Automatic_Mode120
	BCF        PORTE+0, 2
	GOTO       L__Automatic_Mode121
L__Automatic_Mode120:
	BSF        PORTE+0, 2
L__Automatic_Mode121:
;Traffic Light Control System Project.c,150 :: 		RED2 = 1;   // Red is on & street2 is Closed
	BSF        PORTE+0, 0
;Traffic Light Control System Project.c,151 :: 		PORTC = display[counter];   // count down from 20 to 0
	MOVF       _counter+0, 0
	ADDLW      _display+0
	MOVWF      FSR
	MOVF       INDF+0, 0
	MOVWF      PORTC+0
;Traffic Light Control System Project.c,152 :: 		Delay_ms(wait);
	MOVLW      4
	MOVWF      R11+0
	MOVLW      12
	MOVWF      R12+0
	MOVLW      51
	MOVWF      R13+0
L_Automatic_Mode39:
	DECFSZ     R13+0, 1
	GOTO       L_Automatic_Mode39
	DECFSZ     R12+0, 1
	GOTO       L_Automatic_Mode39
	DECFSZ     R11+0, 1
	GOTO       L_Automatic_Mode39
	NOP
	NOP
;Traffic Light Control System Project.c,153 :: 		Auto_Manual();
	CALL       _Auto_Manual+0
;Traffic Light Control System Project.c,154 :: 		if (RED1 == 1) goto AUTO1;
	BTFSS      PORTA+0, 0
	GOTO       L_Automatic_Mode40
	GOTO       ___Automatic_Mode_AUTO1
L_Automatic_Mode40:
;Traffic Light Control System Project.c,146 :: 		for(counter = 0; counter < 20; counter++){
	INCF       _counter+0, 1
;Traffic Light Control System Project.c,155 :: 		}
	GOTO       L_Automatic_Mode36
L_Automatic_Mode37:
;Traffic Light Control System Project.c,157 :: 		for(counter = 17; counter < 20; counter++){
	MOVLW      17
	MOVWF      _counter+0
L_Automatic_Mode41:
	MOVLW      20
	SUBWF      _counter+0, 0
	BTFSC      STATUS+0, 0
	GOTO       L_Automatic_Mode42
;Traffic Light Control System Project.c,158 :: 		YELLOW1 = 1;
	BSF        PORTA+0, 1
;Traffic Light Control System Project.c,159 :: 		RED1 = GREEN1 = 0;
	BCF        PORTA+0, 2
	BTFSC      PORTA+0, 2
	GOTO       L__Automatic_Mode122
	BCF        PORTA+0, 0
	GOTO       L__Automatic_Mode123
L__Automatic_Mode122:
	BSF        PORTA+0, 0
L__Automatic_Mode123:
;Traffic Light Control System Project.c,160 :: 		YELLOW2 = GREEN2 = 0;
	BCF        PORTE+0, 2
	BTFSC      PORTE+0, 2
	GOTO       L__Automatic_Mode124
	BCF        PORTE+0, 1
	GOTO       L__Automatic_Mode125
L__Automatic_Mode124:
	BSF        PORTE+0, 1
L__Automatic_Mode125:
;Traffic Light Control System Project.c,161 :: 		RED2 = 1;    // Red is still on & Yellow is on. street2 is closed street1 is ready
	BSF        PORTE+0, 0
;Traffic Light Control System Project.c,162 :: 		PORTC = display[counter]; // count down from 3 to 0
	MOVF       _counter+0, 0
	ADDLW      _display+0
	MOVWF      FSR
	MOVF       INDF+0, 0
	MOVWF      PORTC+0
;Traffic Light Control System Project.c,163 :: 		Delay_ms(wait);
	MOVLW      4
	MOVWF      R11+0
	MOVLW      12
	MOVWF      R12+0
	MOVLW      51
	MOVWF      R13+0
L_Automatic_Mode44:
	DECFSZ     R13+0, 1
	GOTO       L_Automatic_Mode44
	DECFSZ     R12+0, 1
	GOTO       L_Automatic_Mode44
	DECFSZ     R11+0, 1
	GOTO       L_Automatic_Mode44
	NOP
	NOP
;Traffic Light Control System Project.c,164 :: 		Auto_Manual();
	CALL       _Auto_Manual+0
;Traffic Light Control System Project.c,165 :: 		if (RED1 == 1) goto AUTO1;
	BTFSS      PORTA+0, 0
	GOTO       L_Automatic_Mode45
	GOTO       ___Automatic_Mode_AUTO1
L_Automatic_Mode45:
;Traffic Light Control System Project.c,157 :: 		for(counter = 17; counter < 20; counter++){
	INCF       _counter+0, 1
;Traffic Light Control System Project.c,166 :: 		}
	GOTO       L_Automatic_Mode41
L_Automatic_Mode42:
;Traffic Light Control System Project.c,167 :: 		for(counter=8;counter<20;counter++){
	MOVLW      8
	MOVWF      _counter+0
L_Automatic_Mode46:
	MOVLW      20
	SUBWF      _counter+0, 0
	BTFSC      STATUS+0, 0
	GOTO       L_Automatic_Mode47
;Traffic Light Control System Project.c,168 :: 		GREEN1 = YELLOW1 = 0;
	BCF        PORTA+0, 1
	BTFSC      PORTA+0, 1
	GOTO       L__Automatic_Mode126
	BCF        PORTA+0, 2
	GOTO       L__Automatic_Mode127
L__Automatic_Mode126:
	BSF        PORTA+0, 2
L__Automatic_Mode127:
;Traffic Light Control System Project.c,169 :: 		RED1 = 1;   // Red is on    street1 is closed
	BSF        PORTA+0, 0
;Traffic Light Control System Project.c,170 :: 		GREEN2 = 1;  // Green is on   street2 is opened
	BSF        PORTE+0, 2
;Traffic Light Control System Project.c,171 :: 		RED2 = YELLOW2 = 0;
	BCF        PORTE+0, 1
	BTFSC      PORTE+0, 1
	GOTO       L__Automatic_Mode128
	BCF        PORTE+0, 0
	GOTO       L__Automatic_Mode129
L__Automatic_Mode128:
	BSF        PORTE+0, 0
L__Automatic_Mode129:
;Traffic Light Control System Project.c,172 :: 		PORTC = display[counter];  // Count down from 12 to 0
	MOVF       _counter+0, 0
	ADDLW      _display+0
	MOVWF      FSR
	MOVF       INDF+0, 0
	MOVWF      PORTC+0
;Traffic Light Control System Project.c,173 :: 		Delay_ms(wait);
	MOVLW      4
	MOVWF      R11+0
	MOVLW      12
	MOVWF      R12+0
	MOVLW      51
	MOVWF      R13+0
L_Automatic_Mode49:
	DECFSZ     R13+0, 1
	GOTO       L_Automatic_Mode49
	DECFSZ     R12+0, 1
	GOTO       L_Automatic_Mode49
	DECFSZ     R11+0, 1
	GOTO       L_Automatic_Mode49
	NOP
	NOP
;Traffic Light Control System Project.c,174 :: 		Auto_Manual();
	CALL       _Auto_Manual+0
;Traffic Light Control System Project.c,175 :: 		if (GREEN1 == 1) goto AUTO2;
	BTFSS      PORTA+0, 2
	GOTO       L_Automatic_Mode50
	GOTO       ___Automatic_Mode_AUTO2
L_Automatic_Mode50:
;Traffic Light Control System Project.c,167 :: 		for(counter=8;counter<20;counter++){
	INCF       _counter+0, 1
;Traffic Light Control System Project.c,176 :: 		}
	GOTO       L_Automatic_Mode46
L_Automatic_Mode47:
;Traffic Light Control System Project.c,177 :: 		for(counter=17;counter<20;counter++){
	MOVLW      17
	MOVWF      _counter+0
L_Automatic_Mode51:
	MOVLW      20
	SUBWF      _counter+0, 0
	BTFSC      STATUS+0, 0
	GOTO       L_Automatic_Mode52
;Traffic Light Control System Project.c,178 :: 		YELLOW1 = GREEN1 = 0;
	BCF        PORTA+0, 2
	BTFSC      PORTA+0, 2
	GOTO       L__Automatic_Mode130
	BCF        PORTA+0, 1
	GOTO       L__Automatic_Mode131
L__Automatic_Mode130:
	BSF        PORTA+0, 1
L__Automatic_Mode131:
;Traffic Light Control System Project.c,179 :: 		RED1 = 1;   //Red is still on & Yellow is on  street1 is closed & street2 is ready
	BSF        PORTA+0, 0
;Traffic Light Control System Project.c,180 :: 		YELLOW2 =1;
	BSF        PORTE+0, 1
;Traffic Light Control System Project.c,181 :: 		GREEN2 = RED2 = 0;
	BCF        PORTE+0, 0
	BTFSC      PORTE+0, 0
	GOTO       L__Automatic_Mode132
	BCF        PORTE+0, 2
	GOTO       L__Automatic_Mode133
L__Automatic_Mode132:
	BSF        PORTE+0, 2
L__Automatic_Mode133:
;Traffic Light Control System Project.c,182 :: 		PORTC = display[counter];   // Count down from 3 to 0
	MOVF       _counter+0, 0
	ADDLW      _display+0
	MOVWF      FSR
	MOVF       INDF+0, 0
	MOVWF      PORTC+0
;Traffic Light Control System Project.c,183 :: 		Delay_ms(wait);
	MOVLW      4
	MOVWF      R11+0
	MOVLW      12
	MOVWF      R12+0
	MOVLW      51
	MOVWF      R13+0
L_Automatic_Mode54:
	DECFSZ     R13+0, 1
	GOTO       L_Automatic_Mode54
	DECFSZ     R12+0, 1
	GOTO       L_Automatic_Mode54
	DECFSZ     R11+0, 1
	GOTO       L_Automatic_Mode54
	NOP
	NOP
;Traffic Light Control System Project.c,184 :: 		Auto_Manual();
	CALL       _Auto_Manual+0
;Traffic Light Control System Project.c,185 :: 		if (RED2 == 1) goto AUTO1;
	BTFSS      PORTE+0, 0
	GOTO       L_Automatic_Mode55
	GOTO       ___Automatic_Mode_AUTO1
L_Automatic_Mode55:
;Traffic Light Control System Project.c,177 :: 		for(counter=17;counter<20;counter++){
	INCF       _counter+0, 1
;Traffic Light Control System Project.c,186 :: 		}
	GOTO       L_Automatic_Mode51
L_Automatic_Mode52:
;Traffic Light Control System Project.c,187 :: 		}
	GOTO       L_Automatic_Mode34
;Traffic Light Control System Project.c,190 :: 		}
L_Automatic_Mode33:
;Traffic Light Control System Project.c,191 :: 		}
L_end_Automatic_Mode:
	RETURN
; end of _Automatic_Mode

_Manual_Mode:

;Traffic Light Control System Project.c,195 :: 		void Manual_Mode(){
;Traffic Light Control System Project.c,196 :: 		if(RED1 == 1 || GREEN2 ==  1){
	BTFSC      PORTA+0, 0
	GOTO       L__Manual_Mode72
	BTFSC      PORTE+0, 2
	GOTO       L__Manual_Mode72
	GOTO       L_Manual_Mode58
L__Manual_Mode72:
;Traffic Light Control System Project.c,197 :: 		SEG1 = SEG2 = 0;
	BCF        PORTD+0, 1
	BTFSC      PORTD+0, 1
	GOTO       L__Manual_Mode135
	BCF        PORTD+0, 0
	GOTO       L__Manual_Mode136
L__Manual_Mode135:
	BSF        PORTD+0, 0
L__Manual_Mode136:
;Traffic Light Control System Project.c,198 :: 		SEG3 = SEG4 = 1;
	BSF        PORTD+0, 3
	BTFSC      PORTD+0, 3
	GOTO       L__Manual_Mode137
	BCF        PORTD+0, 2
	GOTO       L__Manual_Mode138
L__Manual_Mode137:
	BSF        PORTD+0, 2
L__Manual_Mode138:
;Traffic Light Control System Project.c,199 :: 		for(counter = 17; counter < 20; counter++){
	MOVLW      17
	MOVWF      _counter+0
L_Manual_Mode59:
	MOVLW      20
	SUBWF      _counter+0, 0
	BTFSC      STATUS+0, 0
	GOTO       L_Manual_Mode60
;Traffic Light Control System Project.c,200 :: 		RED2 = GREEN2 = 0;
	BCF        PORTE+0, 2
	BTFSC      PORTE+0, 2
	GOTO       L__Manual_Mode139
	BCF        PORTE+0, 0
	GOTO       L__Manual_Mode140
L__Manual_Mode139:
	BSF        PORTE+0, 0
L__Manual_Mode140:
;Traffic Light Control System Project.c,201 :: 		YELLOW2 = 1;
	BSF        PORTE+0, 1
;Traffic Light Control System Project.c,202 :: 		PORTC = display[counter]; //countdown from 3 to 0
	MOVF       _counter+0, 0
	ADDLW      _display+0
	MOVWF      FSR
	MOVF       INDF+0, 0
	MOVWF      PORTC+0
;Traffic Light Control System Project.c,203 :: 		Delay_ms(wait);
	MOVLW      4
	MOVWF      R11+0
	MOVLW      12
	MOVWF      R12+0
	MOVLW      51
	MOVWF      R13+0
L_Manual_Mode62:
	DECFSZ     R13+0, 1
	GOTO       L_Manual_Mode62
	DECFSZ     R12+0, 1
	GOTO       L_Manual_Mode62
	DECFSZ     R11+0, 1
	GOTO       L_Manual_Mode62
	NOP
	NOP
;Traffic Light Control System Project.c,199 :: 		for(counter = 17; counter < 20; counter++){
	INCF       _counter+0, 1
;Traffic Light Control System Project.c,204 :: 		}
	GOTO       L_Manual_Mode59
L_Manual_Mode60:
;Traffic Light Control System Project.c,205 :: 		RED1 = YELLOW1 = 0;
	BCF        PORTA+0, 1
	BTFSC      PORTA+0, 1
	GOTO       L__Manual_Mode141
	BCF        PORTA+0, 0
	GOTO       L__Manual_Mode142
L__Manual_Mode141:
	BSF        PORTA+0, 0
L__Manual_Mode142:
;Traffic Light Control System Project.c,206 :: 		GREEN1 = 1;
	BSF        PORTA+0, 2
;Traffic Light Control System Project.c,207 :: 		GREEN2 = YELLOW2 = 0;
	BCF        PORTE+0, 1
	BTFSC      PORTE+0, 1
	GOTO       L__Manual_Mode143
	BCF        PORTE+0, 2
	GOTO       L__Manual_Mode144
L__Manual_Mode143:
	BSF        PORTE+0, 2
L__Manual_Mode144:
;Traffic Light Control System Project.c,208 :: 		RED2 = 1;
	BSF        PORTE+0, 0
;Traffic Light Control System Project.c,210 :: 		}
	GOTO       L_Manual_Mode63
L_Manual_Mode58:
;Traffic Light Control System Project.c,211 :: 		else if(GREEN1 == 1 || RED2 == 1){
	BTFSC      PORTA+0, 2
	GOTO       L__Manual_Mode71
	BTFSC      PORTE+0, 0
	GOTO       L__Manual_Mode71
	GOTO       L_Manual_Mode66
L__Manual_Mode71:
;Traffic Light Control System Project.c,212 :: 		SEG1 = SEG2 = 1;
	BSF        PORTD+0, 1
	BTFSC      PORTD+0, 1
	GOTO       L__Manual_Mode145
	BCF        PORTD+0, 0
	GOTO       L__Manual_Mode146
L__Manual_Mode145:
	BSF        PORTD+0, 0
L__Manual_Mode146:
;Traffic Light Control System Project.c,213 :: 		SEG3 = SEG4 = 0;
	BCF        PORTD+0, 3
	BTFSC      PORTD+0, 3
	GOTO       L__Manual_Mode147
	BCF        PORTD+0, 2
	GOTO       L__Manual_Mode148
L__Manual_Mode147:
	BSF        PORTD+0, 2
L__Manual_Mode148:
;Traffic Light Control System Project.c,214 :: 		for(counter = 17; counter < 20; counter++){
	MOVLW      17
	MOVWF      _counter+0
L_Manual_Mode67:
	MOVLW      20
	SUBWF      _counter+0, 0
	BTFSC      STATUS+0, 0
	GOTO       L_Manual_Mode68
;Traffic Light Control System Project.c,215 :: 		RED1 = GREEN1 = 0;
	BCF        PORTA+0, 2
	BTFSC      PORTA+0, 2
	GOTO       L__Manual_Mode149
	BCF        PORTA+0, 0
	GOTO       L__Manual_Mode150
L__Manual_Mode149:
	BSF        PORTA+0, 0
L__Manual_Mode150:
;Traffic Light Control System Project.c,216 :: 		YELLOW1 = 1;
	BSF        PORTA+0, 1
;Traffic Light Control System Project.c,217 :: 		YELLOW2 = GREEN2 = 0;
	BCF        PORTE+0, 2
	BTFSC      PORTE+0, 2
	GOTO       L__Manual_Mode151
	BCF        PORTE+0, 1
	GOTO       L__Manual_Mode152
L__Manual_Mode151:
	BSF        PORTE+0, 1
L__Manual_Mode152:
;Traffic Light Control System Project.c,218 :: 		RED2 = 1;
	BSF        PORTE+0, 0
;Traffic Light Control System Project.c,219 :: 		PORTC = display[counter];
	MOVF       _counter+0, 0
	ADDLW      _display+0
	MOVWF      FSR
	MOVF       INDF+0, 0
	MOVWF      PORTC+0
;Traffic Light Control System Project.c,220 :: 		Delay_ms(wait);
	MOVLW      4
	MOVWF      R11+0
	MOVLW      12
	MOVWF      R12+0
	MOVLW      51
	MOVWF      R13+0
L_Manual_Mode70:
	DECFSZ     R13+0, 1
	GOTO       L_Manual_Mode70
	DECFSZ     R12+0, 1
	GOTO       L_Manual_Mode70
	DECFSZ     R11+0, 1
	GOTO       L_Manual_Mode70
	NOP
	NOP
;Traffic Light Control System Project.c,214 :: 		for(counter = 17; counter < 20; counter++){
	INCF       _counter+0, 1
;Traffic Light Control System Project.c,221 :: 		}
	GOTO       L_Manual_Mode67
L_Manual_Mode68:
;Traffic Light Control System Project.c,222 :: 		RED1 = 1;
	BSF        PORTA+0, 0
;Traffic Light Control System Project.c,223 :: 		GREEN1 = YELLOW1 = 0;
	BCF        PORTA+0, 1
	BTFSC      PORTA+0, 1
	GOTO       L__Manual_Mode153
	BCF        PORTA+0, 2
	GOTO       L__Manual_Mode154
L__Manual_Mode153:
	BSF        PORTA+0, 2
L__Manual_Mode154:
;Traffic Light Control System Project.c,224 :: 		RED2 = YELLOW2 = 0;
	BCF        PORTE+0, 1
	BTFSC      PORTE+0, 1
	GOTO       L__Manual_Mode155
	BCF        PORTE+0, 0
	GOTO       L__Manual_Mode156
L__Manual_Mode155:
	BSF        PORTE+0, 0
L__Manual_Mode156:
;Traffic Light Control System Project.c,225 :: 		GREEN2 = 1;
	BSF        PORTE+0, 2
;Traffic Light Control System Project.c,226 :: 		}
L_Manual_Mode66:
L_Manual_Mode63:
;Traffic Light Control System Project.c,227 :: 		}
L_end_Manual_Mode:
	RETURN
; end of _Manual_Mode
