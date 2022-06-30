# Ricerca dell'id corrispondente al nome del pilota caricato nello stack dal chiamante
# Restituisce la stringa contenente l'id del pilota, "20\0" equivale a pilota non valido
# Il valore di ritorno è nello stack sotto al nome del pilota

.section .data
	pilot_0:  .ascii "Pierre Gasly\n      "
	pilot_1:  .ascii "Charles Leclerc\n   "
	pilot_2:  .ascii "Max Verstappen\n    "
	pilot_3:  .ascii "Lando Norris\n      "
	pilot_4:  .ascii "Sebastian Vettel\n  "
	pilot_5:  .ascii "Daniel Ricciardo\n  "
	pilot_6:  .ascii "Lance Stroll\n      "
	pilot_7:  .ascii "Carlos Sainz\n      "
	pilot_8:  .ascii "Antonio Giovinazzi\n"
	pilot_9:  .ascii "Kevin Magnussen\n   "
	pilot_10: .ascii "Alexander Albon\n   "
	pilot_11: .ascii "Nicholas Latifi\n   "
	pilot_12: .ascii "Lewis Hamilton\n    "
	pilot_13: .ascii "Romain Grosjean\n   "
	pilot_14: .ascii "George Russell\n    "
	pilot_15: .ascii "Sergio Perez\n      "
	pilot_16: .ascii "Daniil Kvyat\n      "
	pilot_17: .ascii "Kimi Raikkonen\n    "
	pilot_18: .ascii "Esteban Ocon\n      "
	pilot_19: .ascii "Valtteri Bottas\n   "

.section .text
	.global find_id
	.type find_id, @function
find_id:
	# salvataggio ebp e spostamento per farlo puntare ai parametri
	pushl %ebp
	movl %esp, %ebp
	addl $8, %ebp
	# salvataggio registri
	pushl %eax
	pushl %ecx
	# passaggio valore di ritorno e parametri per strcmp
	subl $4, %esp
	pushl (%ebp)
	leal pilot_0, %eax
	pushl %eax
	# azzeramento contatore (id)
	xorl %ecx, %ecx
	# confronto delle stringhe piloti con l'input dato
	switch_case:
		# chiamo strcmp e verifico il valore restituito
		call strcmp
		cmpl $1, 8(%esp)
		je id_conversion
		# se la stringa non corrisponde, verifico che ci siano ancora piloti
		incl %ecx
		cmpl $20, %ecx
		je id_conversion
		# se ci sono ancora piloti, passo al successivo (19B = distanza stringhe piloti)
		addl $19, (%esp)
		jmp switch_case
# conversione dell'id trovato in stringa
id_conversion:
	# scarico la pila dei parametri passati a strcmp
	addl $12, %esp
	# passaggio valore di ritorno e parametro per itoa
	subl $4, %esp
	pushl %ecx
	call itoa
	# scarico la pila del parametro
	addl $4, %esp
	# il valore restituito diventa il valore da restituire al chiamante
	popl 4(%ebp)
# ripristino registri e fine funzione
return:
	popl %ecx
	popl %eax
	popl %ebp
	ret
