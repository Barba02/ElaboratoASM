# Conversione in intero della stringa numerica
# compresa tra i due puntatori passati come parametri
# L'intero risultante viene messo nello stack sotto ai puntatori

.section .text
	.global strcpy_to_int
	.type strcpy_to_int, @function
strcpy_to_int:
	# salvataggio ebp e spostamento per farlo puntare ai parametri
	pushl %ebp
	movl %esp, %ebp
	addl $8, %ebp
	# salvataggio registri
	pushl %eax
	pushl %ebx
	pushl %ecx
	pushl %edx
	pushl %esi
	pushl %edi
	# copia parametri
    movl (%ebp), %edi
    movl 4(%ebp), %esi
	# inizializzazione variabili necessarie
    xorl %eax, %eax
    xorl %ebx, %ebx
	movl $10, %ecx
	# conversione carattere per carattere
	char_conversion:
		cmpl %esi, %edi
		je end_char_conversion
		movb (%esi), %bl
		subb $48, %bl
		xorl %edx, %edx
		mull %ecx
		addl %ebx, %eax
		incl %esi
		jmp char_conversion
	# restituzione risultato
end_char_conversion:
    movl %eax, 8(%ebp)
	# ripristino registri e fine funzione
	popl %edi
	popl %esi
	popl %edx
	popl %ecx
	popl %ebx
	popl %eax
	popl %ebp
	ret
