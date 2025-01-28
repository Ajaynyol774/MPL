;Write Write an X86/64 ALP to accept a string and to display its length
;NAME: Ajay Nyol
;DOP: 28/01/2025

%macro io 4
	mov rax,%1
	mov rdi,%2
	mov rsi,%3
	mov rdx,%4
	syscall
%endmacro
section .data
	msg1 db "Write an X86/64 ALP to accept a string and to display its length",10
	msg1len equ $-msg1
	
	msg2 db " Enter string ",10
	msg2len equ $-msg2
	msg3 db " Lenght of string without loop ",10
	msg3len equ $-msg3
	msg4 db " Lenght of string with loop ",10
	msg4len equ $-msg4
	newline db 10
	len db 0
section .bss
	str1 resb 20
	

section .code
	global _start
	_start:
	io 1,1,msg1,msg1len
	io 1,1,msg2,msg2len
	io 0,0,str1,20
	
	dec rax
	mov rbx,rax
	io 1,1,msg3,msg3len
	call hex_ascii8
	
mov rsi,str1
next:
	mov al,[rsi]
	cmp al,10
	je skip
	inc byte[len]
	inc rsi
	loop next

skip:
	io 1,1,msg4,msg4len
	mov bl,[len]
	call hex_ascii8	
exit:

	mov rax,60
	mov rdi,1
	syscall

hex_ascii8:
	mov rsi,str1
	mov rcx,2
next4:
	rol bl,4
	mov al,bl
	and al,0fh
	cmp al, 9
	
	jbe add30h
	add al,7
add30h:
	add al,30h
	mov [rsi],al
	inc rsi
	loop next4
	io 1,1,str1,2
	io 1,1,newline,1
	ret

