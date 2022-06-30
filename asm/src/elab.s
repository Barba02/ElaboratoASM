# Funzione che riceve come parametro l'indirizzo della stringa con l'id del pilota trovato
# Il sottoprogramma legge le righe di input scartando quelle non valide
# e stampa in output i tempi delle righe considerate, i livelli dei tre parametri e i dati dell'ultima riga  
# Non viene restituito alcun valore

.section .data
	rpm_max: .long 0
	temp_max: .long 0
	speed_max: .long 0
	speed_sum: .long 0
	rpm_level: .long 0
	temp_level: .long 0
	speed_level: .long 0
	rpm_lower_bound: .long 5000
	rpm_higher_bound: .long 10000

.section .text
	.global elab
	.type elab, @function
elab:
	# salvataggio ebp e spostamento per farlo puntare ai parametri
	pushl %ebp
	movl %esp, %ebp
	addl $8, %ebp
	# salvataggio registri
	pushl %eax
	pushl %ebx
	pushl %ecx
	pushl %edx
	# sposto la stringa dell'id in eax
	movl (%ebp), %eax
	# azzero ecx per conteggio righe pilota
	xorl %ecx, %ecx
	# lettura righe
	read_line:
		incl %esi
		cmpb $0, (%esi)
		je end
		movl %esi, %ebx
		# faccio scorrere ebx fino alla prima virgola
		find_first_comma:
			addl $1, %ebx
			cmpb $44, (%ebx)
			jne find_first_comma
		# confronto l'id della riga con quello trovato
		addl $1, %ebx
		subl $4, %esp
		pushl %eax
		pushl %ebx
		call strcmp
		addl $8, %esp
		cmpl $1, (%esp)
		# se gli id non sono uguali vado alla prossima riga
		jne next_line
		addl $4, %esp
		# se sono uguali proseguo copiando il tempo nel file di output
		incl %ecx
		copy_time:
			movb (%esi), %dl
			movb %dl, (%edi)
			incl %esi
			incl %edi
			cmpl %esi, %ebx
			jne copy_time
		# sposto il puntatore dopo la seconda virgola
		find_second_comma:
			addl $1, %esi
			cmpb $44, (%esi)
			jne find_second_comma
		addl $1, %esi
		# trovo la velocità
		movl %esi, %ebx
		find_third_comma:
			addl $1, %ebx
			cmpb $44, (%ebx)
			jne find_third_comma
		subl $4, %esp
		pushl %esi
		pushl %ebx
		call strcpy_to_int
		addl $8, %esp
		popl %edx
		# sommo la velocità al totale per la media
		addl %edx, speed_sum
		# confronto la velocità con il massimo ed eventualmente lo aggiorno
		cmpl speed_max, %edx
		jle find_speed_level
		movl %edx, speed_max
	find_speed_level:
		# trovo il livello della velocità
		subl $4, %esp
		pushl %edx
		pushl $100
		pushl $250
		call find_level
		addl $12, %esp
		popl speed_level
		# trovo gli rpm
		incl %ebx
		movl %ebx, %esi
		find_fourth_comma:
			addl $1, %ebx
			cmpb $44, (%ebx)
			jne find_fourth_comma
		subl $4, %esp
		pushl %esi
		pushl %ebx
		call strcpy_to_int
		addl $8, %esp
		popl %edx
		# confronto gli rpm con il massimo ed eventualmente lo aggiorno
		cmpl rpm_max, %edx
		jle find_rpm_level
		movl %edx, rpm_max
	find_rpm_level:
		# trovo il livello degli rpm
		subl $4, %esp
		pushl %edx
		pushl rpm_lower_bound
		pushl rpm_higher_bound
		call find_level
		addl $12, %esp
		popl rpm_level
		# trovo la temperatura
		incl %ebx
		movl %ebx, %esi
		find_end_row:
			addl $1, %ebx
			cmpb $0, (%ebx)
			je conversion
			cmpb $10, (%ebx)
			jne find_end_row
	conversion:
		subl $4, %esp
		pushl %esi
		pushl %ebx
		call strcpy_to_int
		movl %ebx, %esi
		addl $8, %esp
		popl %edx
		# confronto la temperatura con il massimo ed eventualmente lo aggiorno
		cmpl temp_max, %edx
		jle find_temp_level
		movl %edx, temp_max
	find_temp_level:
		# trovo il livello della temperatura
		subl $4, %esp
		pushl %edx
		pushl $90
		pushl $110
		call find_level
		addl $12, %esp
		popl temp_level
		# stampa livello rpm
		pushl rpm_level
		pushl $44
		call print_level
		addl $8, %esp
		# stampa livello temperatura
		pushl temp_level
		pushl $44
		call print_level
		addl $8, %esp
		# stampa livello velocità
		pushl speed_level
		pushl $10
		call print_level
		addl $8, %esp
		# se l'ultimo carattere è \0 salto in fondo altrimenti passo alla linea successiva
		cmpb $0, (%esi)
		je end
		jmp read_line
	# lettura fino a fine riga
	next_line:
		addl $4, %esp
		next_char:
			incl %esi
			cmpb $0, (%esi)
			je end
			cmpb $10, (%esi)
			je read_line
			jmp next_char
# fine funzione
end:
	# calcolo media
	movl speed_sum, %eax
	xorl %edx, %edx
	divl %ecx
	# stampa ultima riga
	pushl rpm_max
	pushl $44
	call print_int
	movl temp_max, %edx
	movl %edx, 4(%esp)
	call print_int
	movl speed_max, %edx
	movl %edx, 4(%esp)
	call print_int
	movl %eax, 4(%esp)
	movl $10, (%esp)
	call print_int
	addl $8, %esp
	# ripristino registri
	popl %edx
	popl %ecx
	popl %ebx
	popl %eax
	popl %ebp
	ret
