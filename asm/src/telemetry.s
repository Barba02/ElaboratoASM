# Acquisizione degli indirizzi di input e output passati da main.c
# Controllo della validità del pilota e elaborazione dei dati

.section .data
	invalid_string: .string "Invalid\n"
	invalid_pilot_number: .ascii "20,"
	input: .ascii "\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n"

.section .text
	.global telemetry
	.type telemetry, @function
telemetry:
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
	# lettura prima riga
	movl (%ebp), %esi
	leal input, %edi
	xorl %ecx, %ecx
    read_pilot_name:
        movb (%esi, %ecx), %al
        movb %al, (%edi, %ecx)
        incl %ecx
        cmpb $10, %al
        jne read_pilot_name
	# caricamento valore di ritorno e parametro per find_id
	subl $4, %esp
	pushl %edi
	call find_id
	# scarico la pila e controllo se il nome del pilota è valido
	addl $4, %esp
	popl %eax
	subl $4, %esp
	pushl %eax
	leal invalid_pilot_number, %ebx
	pushl %ebx
	call strcmp
	addl $8, %esp
	cmpl $1, (%esp)
	je end_invalid
	# sposto il puntatore oltre il nome del pilota e carico l'id per elab
	addl $4, %esp
	addl %ecx, %esi
	subl $1, %esi
	pushl %eax
	movl 4(%ebp), %edi
	call elab
	addl $4, %esp
	jmp end
# stampa di invalid
end_invalid:
	addl $4, %esp
	leal invalid_string, %esi
	movl 4(%ebp), %edi
	movl $9, %ecx
	xorl %edx, %edx
	invalid_copy:
		movb (%esi), %dl
		movb %dl, (%edi)
		incl %esi
		incl %edi
		loop invalid_copy
# ripristino registri e fine funzione
end:
	popl %edi
	popl %esi
	popl %edx
	popl %ecx
	popl %ebx
	popl %eax
	popl %ebp
	ret
