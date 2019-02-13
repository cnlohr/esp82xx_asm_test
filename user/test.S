#define _INASM_

#include "test.h"

.global ASMNop
.align 16
ASMNop:
	addi a1, a1, -68
	s32i a3, a1, 8
	rsr a3, ccount
	//Do nothing (this is a NOP test)
	rsr a2, ccount
	sub a2, a2, a3
	l32i a3, a1, 8
	addi a1, a1, 68
	ret

.macro PROLOGUE
	addi a1, a1, -68
	s32i a3, a1, 8
	s32i a4, a1, 12
	s32i a5, a1, 16
	s32i a6, a1, 20
.endm

.macro START
	rsr a3, ccount
.endm

.macro EPILOGUE
	rsr a2, ccount
	sub a2, a2, a3
	addi a2, a2, -1
	l32i a3, a1, 8
	l32i a4, a1, 12
	l32i a5, a1, 16
	l32i a6, a1, 20
	addi a1, a1, 68
	ret
.endm


.align 16
PIN_IN:
	.long 0x60000318


.global ASMTest1
.align 16
ASMTest1:
	PROLOGUE
	l32r a4, PIN_IN
	START
	l32i a5, a4, 0
	l32i a6, a4, 0
	add a5, a6, a5
	EPILOGUE

.global ASMTest2
.align 16
ASMTest2:
	PROLOGUE
	l32r a4, PIN_IN
	START
	l32i a5, a4, 0
	nop
	nop
	nop
	l32i a6, a4, 0
	nop
	nop
	nop
	add a5, a6, a5
	EPILOGUE

.global ASMTest3
.align 16
ASMTest3:
	PROLOGUE
	START

	EPILOGUE


