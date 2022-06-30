# Funzione che riceve come parametri un valore e due soglie
# Il programma confronta il valore con gli intervalli delineati dalle soglie
# e restituisce un intero [1..3] a seconda del livello trovato

.section .text
	.global find_level
	.type find_level, @function
find_level:
    # salvataggio ebp e spostamento per farlo puntare ai parametri
	pushl %ebp
	movl %esp, %ebp
	addl $8, %ebp
	# salvataggio registri
	pushl %eax
	pushl %ebx
	pushl %ecx
    # copio i parametri nei registri
    movl 8(%ebp), %eax
    movl 4(%ebp), %ebx
    movl (%ebp), %ecx
    # comparo i valori e restituisco il livello trovato
    cmpl %ebx, %eax
    jg level2
    movl $1, 12(%ebp)
    jmp level_finded
level2:
    cmpl %ecx, %eax
    jg level3
    movl $2, 12(%ebp)
    jmp level_finded
level3:
    movl $3, 12(%ebp)
level_finded:
	# ripristino registri
    popl %ecx
	popl %ebx
	popl %eax
	popl %ebp
	ret
