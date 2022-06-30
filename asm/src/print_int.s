# Funzione che riceve un intero e un carattere da stampare
# Non viene restituito alcun valore

.section .text
	.global print_int
	.type print_int, @function
print_int:
	# salvataggio ebp e spostamento per farlo puntare ai parametri
	pushl %ebp
	movl %esp, %ebp
	addl $8, %ebp
	# salvataggio registri
	pushl %eax
	pushl %ebx
	pushl %ecx
	pushl %edx
	# caricamento numero e divisore
	movl 4(%ebp), %eax
	movl $10, %ebx
	# azzeramento contatore e resto
	xorl %ecx, %ecx
	xorl %edx, %edx
	# salvataggio nello stack delle singole cifre e conteggio
	pushing:
		cmpl $10, %eax
		jl last
		divl %ebx
		pushl %edx
		xorl %edx, %edx
		incl %ecx
		jmp pushing
# salvataggio ultima cifra
last:
	pushl %eax
	incl %ecx
	# copio le cifre in output
	popping:
		popl %eax
		addl $48, %eax
		movb %al, (%edi)
		incl %edi
		loop popping
	# stampo carattere finale
	movb (%ebp), %al
	movb %al, (%edi)
	incl %edi
	# ripristino registri e fine funzione
	popl %edx
	popl %ecx
	popl %ebx
	popl %eax
	popl %ebp
	ret
