# Comparazione tra le due stringhe caricate nello stack dal chiamante
# Restituisce 1 se le stringhe sono uguali, 0 altrimenti
# Il valore di ritorno è nello stack sotto ai parametri

.section .text
	.global strcmp
	.type strcmp, @function
strcmp:
	# salvataggio ebp e spostamento per farlo puntare ai parametri
	pushl %ebp
	movl %esp, %ebp
	addl $8, %ebp
	# salvataggio registri
	pushl %eax
	pushl %ebx
	pushl %ecx
	pushl %edx
	# azzeramento contatore e caricamento parametri
	xorl %ecx, %ecx
	movl (%ebp), %ebx
	movl 4(%ebp), %eax
	char_by_char:
		# confronto le due stringhe carattere per carattere
		# se, a parità di posizione, i due caratteri differiscono, le stringhe sono diverse
		movb (%eax, %ecx), %dl
		cmpb %dl, (%ebx, %ecx)
		jne not_equal
		# se i caratteri sono uguali e uno dei due è '\0' o '\n' o ',', le stringhe sono uguali
		cmpb $0, %dl
		je equal
		cmpb $10, %dl
		je equal
		cmpb $44, %dl
		je equal
		# incremento il contatore e passo al carattere successivo
        incl %ecx
		jmp char_by_char
# restituisco 0 per indicare che le stringhe sono diverse
not_equal:
	movl $0, 8(%ebp)
	jmp return
# restituisco 1 per indicare che le stringhe sono uguali
equal:
	movl $1, 8(%ebp)
# ripristino registri e fine funzione
return:
	popl %edx
	popl %ecx
	popl %ebx
	popl %eax
	popl %ebp
	ret
