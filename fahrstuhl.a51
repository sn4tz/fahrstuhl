; 17/07/2026 10:56:12

#cpu = 89S8252	; @12 MHz

#use LCALL

; Initialisierung
mov SP, # 7Fh	; Stackbeginn

init:
; Ausgabe
setb P0.5
clr P0.6
setb P0.7
; Logik
jnb P0.3, init	
jb P0.2, error
jb P0.4, error 

warteUnten:
; Ausgabe
clr P0.5
clr P0.6
clr P0.7
; Logik
clr P0.1								; Clear mögliche Eingabe durch "Taster Aufwäts"
jnb P0.3, error					; Error wenn "Endschalter Unten" nicht gedrückt im Zustand "warteUnten"
jb P0.2, error					; Error wenn "Endschalter Unten" gedrückt
jb P.04, error					; Error wenn "Positionsschalter" gedrückt
jb P0.0, langsamHoch			; Eingabe "Taster Abwärts" ist vorhanden, wechsle Zustand
sjmp warteUnten					; 

langsamHoch:
134

hoch:
warteOben:
langsamRunter:
runter:

error:

end
; * * * Hauptprogramm Ende * * *
