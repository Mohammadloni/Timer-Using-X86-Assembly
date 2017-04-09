.include"m16def.inc"
.org 0
 .equ	Second1		=	0x60
 .equ	Second2		=	0x61
 .equ	miniute1	=	0x62
 .equ	miniute2	=	0x63
 .equ	hour1   	=	0x64
 .equ	hour2		=	0x65
 .equ	s1	    	=	0x66
 .equ	s2		    =	0x67
 .equ	s3		    =	0x68
 .equ	s		    =	0x69
   ldi r16,0xff
   out ddrc,r16
   ldi r16,0xff
   out ddrd,r16
   ldi r23,0
 rjmp l1
      segment:.db	0X3F,0X06,0X5B,0X4F,0X66,0X6D,0X7D,0X07,0X7F,0X6F
l1:
    sts second1,r23
    ldi r23,1
	sts second2,r23
ldi r23,1
	sts miniute1,r23
ldi r23,1
	sts miniute2,r23
ldi r23,1
	sts hour1,r23
ldi r23,1
	sts hour2,r23
	ldi r23,0
    ldi r26,0x0
	ldi r17,0x3f
	ldi r18,0x3f
	ldi r19,0x3f
	ldi r20,0x3f
	ldi r21,0x3f
	ldi r22,0x3f
    ldi r25,19
decres: 
l2: rcall delay
    rcall delay
    ldi r16,0b11011111
    out portc,r26
    out portd,r16
	out portc,r17
	 rcall delay
    ldi r16,0b11111110
    out portc,r26
    out portd,r16
	out portc,r22
	rcall delay
    ldi r16,0b11111101
	out portc,r26
	out portd,r16
	out portc,r21
	rcall delay
	ldi r16,0b11111011
	out portc,r26
	out portd,r16
	out portc,r20
	rcall delay
	ldi r16,0b11110111
	out portc,r26
	out portd,r16
	out portc,r19
	rcall delay
	ldi r16,0b11101111
    out portc,r26
	out portd,r16
	out portc,r18
	rcall delay
	ldi r16,0b11011111
    out portc,r26
    out portd,r16
	out portc,r17
de: dec r25
    brne decres
l3:
    LDI  ZL,LOW(segment * 2)
    LDI  ZH,HIGH(segment * 2) 
	lds r23,second1
	add zl,r23
	lpm r17,z
	inc r23
	sts second1,r23
	cpi r23,11
	brne l2
	ldi r23,0x1
	sts second1,r23
	ldi r17,0x3f
l4: 
    LDI  ZL,LOW(segment * 2)
    LDI  ZH,HIGH(segment * 2)
	lds r23,second2
	add zl,r23
	lpm  r18,z
	inc r23
	sts second2,r23
	cpi r23,7
	brne cb1
	breq cb2
cb1:
    rjmp l2
cb2:
    ldi r23,0x1
	sts second2,r23
	ldi r18,0x3f
l5:
    LDI  ZL,LOW(segment * 2)
    LDI  ZH,HIGH(segment * 2)
	lds r23,miniute1
	add zl,r23
	lpm  r19,z
	inc r23
	sts miniute1,r23
	cpi r23,11
	brne ca1
	breq ca2
ca1:
    rjmp l2

ca2:
    ldi r23,0x1
	sts miniute1,r23
	ldi r19,0x3f
	
l6:  LDI  ZL,LOW(segment * 2)
     LDI  ZH,HIGH(segment * 2)
	lds r23,miniute2
	add zl,r23
	lpm  r20,z
	inc r23
	sts miniute2,r23
	cpi r23,7
	brne cb3
	breq cb4
cb3:
    rjmp l2
cb4:
    ldi r23,0x1
	sts miniute2,r23
	ldi r20,0x3f

l7:
    LDI  ZL,LOW(segment * 2)
    LDI  ZH,HIGH(segment * 2)
	lds r23,hour1
	add zl,r23
	lpm  r21,z
	inc r23
	sts hour1,r23
	cpi r23,5
	brne bro
	lds r23,hour2
	cpi r23,3
	brne cc3
    ldi r23,0x1
	sts hour2,r23
	ldi r22,0x3f
	sts hour1,r23
	ldi r21,0x3f
	rjmp l2
bro:
    lds r23,hour1
	cpi r23,11
	brne cc3
	breq cc4
cc3:
    rjmp l2
cc4:
    ldi r23,0x1
	sts hour1,r23
	ldi r21,0x3f

l8:
  LDI  ZL,LOW(segment * 2)
    LDI  ZH,HIGH(segment * 2)
	lds r23,hour2
	add zl,r23
	lpm  r22,z
	inc r23
	sts hour2,r23
	cpi r23,4
	brne cd1
	breq cd2
cd1:
    rjmp l2
cd2:
	sts hour2,r23
	ldi r22,0x3f
    rjmp l2

delay:
    
	  ldi r28,20
w1:   ldi r27,20  
w2:	  dec r27 
	  nop
      brne w2
	  dec r28
	  nop
	  brne w1
      ret
