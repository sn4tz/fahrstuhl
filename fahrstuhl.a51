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
jb P0.3, init						; wenn "Endschalter Unten" nicht gedrückt, bleibe in "init"
jnb P0.2, error					; Error wenn "Endschalter Oben" und "Endschalter Unten" gedrückt
jnb P0.4, error 					; Error wenn "Positionsschalter" und "Endschalter Unten" gedrückt
; sjmp warteUnten				; wechsel zu "warteUnten"

warteUnten:
; Ausgabe
clr P0.5
clr P0.6
clr P0.7
; Logik
jb P0.3, error					; Error wenn "Endschalter Unten" nicht gedrückt im Zustand "warteUnten"
jnb P0.2, error					; Error wenn "Endschalter Unten" gedrückt
jnb P0.4, error					; Error wenn "Positionsschalter" gedrückt
jb P0.0, 	warteUnten				; Eingabe "Taster Abwärts" ist nicht gedrückt, bleibe in "warteUnten"
jnb P0.1, warteUnten				; Eingabe "Taster Aufwärts" ist gedrückt, bleibe in "warteUnten"
; sjmp langsamHoch				; wechsel zu "langsamHoch"

langsamHoch:
; Ausgabe
setb P0.5
setb P0.6
; Logik
jnb P0.3, error					; Error wenn "Endschalter Unten" gedrückt
jb P0.2, langsamHochNichtP02	; Fallunterscheidung wenn "Endschalter Oben" nicht gedrückt ist
jnb P0.4, error					; Error wenn "Endschalter Oben" und "Positionsschalter" gleichzeitig gedrückt sind
sjmp warteOben					; wechsel Zustand in "warteOben" weil nur "Endschalter Oben" gedrückt
	langsamHochNichtP02:			; wenn "Endschalter Oben" nicht gedrückt
	jb P0.4, langsamHoch			; wenn "Positionsschalter" und "Endschalter Oben" nicht gedrückt, bleibe in "langsamHoch"
;	sjmp hoch						; wenn "Positionsschalter" gedrückt und "Endschalter Oben" nicht gedrückt, wechsel zu "hoch"

hoch:
; Ausgabe
clr P0.5
; Logik
jnb P0.3, error					; Error wenn "Endschalter Unten" gedrückt
jnb P0.2, error					; Error wenn "Endschalter Oben" gedrückt
jnb P0.4, langsamHoch			; wenn "Positionsschalter" gedrückt, wechsel zu "langsamHoch"
sjmp hoch						; weiter zu "hoch"

warteOben:
; Ausgabe
clr P0.5
clr P0.6
; Logik
jb P0.2, error					; Error wenn "Endschalter Oben" nicht gedrückt
jnb P0.3, error					; Error wenn "Endschalter Unten" gedrückt
jnb P0.4, error					; Error wenn "Positionsschalter" gedrückt
jb P0.1, warteOben				; wenn "Taster Aufwärts" nicht gedrückt, bleibe in "warteOben"
jnb P0.0, warteOben				; wenn "Taster Abwäts" gedrückt, bleibe in "warteOben"
; sjmp langsamRunter			; weiter zu "langsamRunter"

langsamRunter:
; Ausgabe 
setb P0.5
setb P0.7
; Logik
jnb P0.2, error					; Error wenn "Endschalter Oben" gedrückt
jb P0.3, langsamRunterNichtP03	; Fallunterscheidung wenn "Endschalter Unten" nicht gedrückt ist
jnb P0.4, error					; Error wenn "Endschalter Unten" und "Positionsschalter" gleichzeitig gedrückt sind
sjmp warteUnten					; wechsel Zustand in "warteUnten" wenn nur "Endschalter Unten" gedrückt
	langsamRunterNichtP03:			; wenn "Endschalter Unten" nicht gedrückt
	jb P0.4, langsamRunter			; wenn "Positionsschalter" und "Endschalter Unten" nicht gedrückt, bleibe in "langsamRunter"
;	sjmp runter						; wenn "Positionsschalter" gedrückt und "Endschalter Unten" nicht gedrückt, wechsel zu "runter"

runter:
; Ausgabe 
clr P0.5
; Logik
jnb P0.3, error					; Error wenn "Endschalter Unten" gedrückt
jnb P0.2, error					; Error wenn "Endschalter Oben" gedrückt
jnb P0.4, langsamRunter			; wenn "Positionsschalter" gedrückt, wechsel zu "langsamRunter"
sjmp runter						; bleib in "runter"

error:
; Ausgabe
clr P0.5
clr P0.6
clr P0.7

end
; * * * Hauptprogramm Ende * * *
