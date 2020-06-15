
	.text
	li $v0,33    #-- Midi-out
	li $a0, 61  #-- Nota 
	li $a1, 500 #-- Duracion
	li $a2, 88    #-- Instrumento
	li $a3, 125 #-- Volumen
	syscall
	
	li $v0,33    #-- Midi-out
	li $a0, 63  #-- Nota 
	li $a1, 500 #-- Duracion
	li $a2, 88    #-- Instrumento
	li $a3, 125 #-- Volumen
	syscall
	
	li $v0,33    #-- Midi-out
	li $a0, 65  #-- Nota 
	li $a1, 500 #-- Duracion
	li $a2, 88    #-- Instrumento
	li $a3, 125 #-- Volumen
	
	syscall
	li $v0,33    #-- Midi-out
	li $a0, 66  #-- Nota 
	li $a1, 500 #-- Duracion
	li $a2, 88    #-- Instrumento
	li $a3, 125 #-- Volumen
	syscall
	
	syscall
	li $v0,33    #-- Midi-out
	li $a0, 68  #-- Nota 
	li $a1, 500 #-- Duracion
	li $a2, 88    #-- Instrumento
	li $a3, 125 #-- Volumen
	syscall
	
	syscall
	li $v0,33    #-- Midi-out
	li $a0, 70  #-- Nota 
	li $a1, 500 #-- Duracion
	li $a2, 88    #-- Instrumento
	li $a3, 125 #-- Volumen
	syscall
	
	syscall
	li $v0,33    #-- Midi-out
	li $a0, 72  #-- Nota 
	li $a1, 500 #-- Duracion
	li $a2, 88    #-- Instrumento
	li $a3, 125 #-- Volumen
	syscall
	
	li $v0, 10 
	syscall
	
	    
