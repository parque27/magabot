(define (problem pb_avancat1a)
    (:domain magabot-avancat-strips)
    (:objects
        r1 r2 - robot
        pkg1 pkg2 pkg3 pkg4 - paquet

        c11 c12 c13 c14 c15 c16 - casella  ; fila 1
        c21 c24 c26 - casella               ; fila 2 (c22 c23 c25 = paret)
        c31 c32 c36 - casella               ; fila 3 (c33 c34 c35 = paret)
        c42 c44 c45 c46 - casella           ; fila 4 (c41 c43 = paret)
        c51 c52 c53 c54 - casella           ; fila 5 (c55 c56 = paret)
        c62 c64 c65 c66 - casella           ; fila 6 (c61 c63 = paret)
    )

    (:init
        (dispensador c66)
        (carregador c62)
        (estanteria c24)
        (estanteria c51)

        (robot-a r1 c16)
        (robot-a r2 c42)
        (robot-buit r1)
        (robot-buit r2)

        ; Pila E1: pkg1(bottom) pkg2 pkg3 pkg4(top)
        (cim-estanteria pkg4 c24)
        (sobre-paquet pkg4 pkg3)
        (sobre-paquet pkg3 pkg2)
        (sobre-paquet pkg2 pkg1)

        (= (energia-total) 0)
        (= (pes pkg1) 4)
        (= (pes pkg2) 3)
        (= (pes pkg3) 2)
        (= (pes pkg4) 1)

        (= (energia r1) 20)
        (= (max-energia r1) 50)
        (= (carrega-actual r1) 0)
        (= (max-carrega r1) 10)

        (= (energia r2) 20)
        (= (max-energia r2) 50)
        (= (carrega-actual r2) 0)
        (= (max-carrega r2) 10)

        ; Caselles lliures (robots i estanteries/dispensador/carregador no compten)
        (lliure c11) (lliure c12) (lliure c13) (lliure c14) (lliure c15)
        (lliure c21) (lliure c26)
        (lliure c31) (lliure c32) (lliure c36)
        (lliure c44) (lliure c45) (lliure c46)
        (lliure c52) (lliure c53) (lliure c54)
        (lliure c64) (lliure c65)

        ; ── Adjacències horitzontals ──
        ; Fila 1
        (adj c11 c12) (adj c12 c11)
        (adj c12 c13) (adj c13 c12)
        (adj c13 c14) (adj c14 c13)
        (adj c14 c15) (adj c15 c14)
        (adj c15 c16) (adj c16 c15)
        ; Fila 2: c21 i c26 separats per parets, sense connexió entre ells
        ; Fila 3: c31-c32 (c33+ = paret)
        (adj c31 c32) (adj c32 c31)
        ; Fila 4: c44-c45-c46 (c42 aïllat horitzontalment)
        (adj c44 c45) (adj c45 c44)
        (adj c45 c46) (adj c46 c45)
        ; Fila 5: c51-c52-c53-c54
        (adj c51 c52) (adj c52 c51)
        (adj c52 c53) (adj c53 c52)
        (adj c53 c54) (adj c54 c53)
        ; Fila 6: c64-c65-c66 (c62 aïllat horitzontalment)
        (adj c64 c65) (adj c65 c64)
        (adj c65 c66) (adj c66 c65)
        (adj c46 c64) (adj c64 c46)

        ; ── Adjacències verticals ──
        ; Columna 1: c11-c21-c31 (c41=paret, c51=E2 no transitable, c61=paret)
        (adj c11 c21) (adj c21 c11)
        (adj c21 c31) (adj c31 c21)
        ; Columna 2: c12 no connecta avall (c22=paret); c32-c42-c52-c62
        (adj c32 c42) (adj c42 c32)
        (adj c42 c52) (adj c52 c42)
        (adj c52 c62) (adj c62 c52)
        ; Columna 3: c13 no connecta avall (c23=paret); c33+ = paret
        ; Columna 4: c14-c24(E1); c44-c54-c64
        (adj c14 c24) (adj c24 c14)
        (adj c44 c54) (adj c54 c44)
        (adj c54 c64) (adj c64 c54)
        ; Columna 5: c15 no connecta avall (c25=paret); c45 no connecta avall (c55=paret)
        ; Columna 6: c16-c26-c36-c46 (c56=paret talla; c66=D no transitable)
        (adj c16 c26) (adj c26 c16)
        (adj c26 c36) (adj c36 c26)
        (adj c36 c46) (adj c46 c36)
    )

    (:goal (and
        (dispensat pkg1)
        (dispensat pkg2)
        (dispensat pkg3)
        (not (dispensat pkg4))
    ))

    (:metric minimize (energia-total))
)