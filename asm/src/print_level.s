# Funzione che riceve come parametri un intero rappresentante il livello da stampare
# e la codifica ascii del carattere da stampare dopo la stringa del livello
# Non viene restituito alcun valore

.section .data
    low: .string "LOW"
	high: .string "HIGH"
	medium: .string "MEDIUM"

.section .text
	.global print_level
	.type print_level, @function
print_level:
    # salvataggio ebp e spostamento per farlo puntare ai parametri
	pushl %ebp
	movl %esp, %ebp
	addl $8, %ebp
	# salvataggio registri
	pushl %eax
	pushl %ebx
	pushl %ecx
	# confronto il livello e carico la stringa giusta
    movl 4(%ebp), %ecx
    cmpl $1, %ecx
    jne medium_level
    leal low, %eax
    jmp print
medium_level:
    cmpl $2, %ecx
    jne high_level
    leal medium, %eax
    jmp print
high_level:
    leal high, %eax
    # stampo la stringa e il carattere alla fine
    print:
        movb (%eax), %bl
        movb %bl, (%edi)
        incl %eax
        incl %edi
        cmpb $0, (%eax)
        jne print
    movb (%ebp), %bl
    movb %bl, (%edi)
    incl %edi
	# ripristino registri
    popl %ecx
	popl %ebx
	popl %eax
	popl %ebp
	ret
