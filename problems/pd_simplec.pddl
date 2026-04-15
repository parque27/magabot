(define (problem simplec)
    (:domain magabot-strips)
    (:objects
        r1 r2 - robot
        pkg1 pkg2 pkg3 - paquet
        c11 c12 c13 c14 c15 - casella
        c21 - casella
        c31 c33 c35 - casella
        c41 c43 c45 - casella
        c51 c52 c53 c54 c55 c56 - casella
        c61 c63 c66 - casella
        c22 c25 - casella   ; estanteries
        c44 - casella        ; dispensador
    )
    (:init
        (dispensador c44)
        (estanteria c22)
        (estanteria c25)
        (robot-a r1 c61)
        (robot-a r2 c55)
        (cim-estanteria pkg3 c25)
        (cim-estanteria pkg1 c22)
        (sobre-paquet pkg1 pkg2)

        (robot-buit r1)
        (robot-buit r2)

        (lliure c11) (lliure c12) (lliure c13) (lliure c14) (lliure c15)
        (lliure c21)
        (lliure c22) (lliure c25)
        (lliure c31) (lliure c33) (lliure c35)
        (lliure c41) (lliure c43) (lliure c44) (lliure c45)
        (lliure c51) (lliure c52) (lliure c53) (lliure c54) (lliure c56)
        (lliure c63) (lliure c66)

        ; Adjacències (idèntiques a simplea)
        (adj c11 c12) (adj c12 c11)
        (adj c12 c22) (adj c22 c12)
        (adj c12 c13) (adj c13 c12)
        (adj c13 c14) (adj c14 c13)
        (adj c14 c15) (adj c15 c14)

        (adj c11 c21) (adj c21 c11)
        (adj c21 c22) (adj c22 c21)
        (adj c15 c25) (adj c25 c15)

        (adj c21 c31) (adj c31 c21)
        (adj c35 c25) (adj c25 c35)

        (adj c41 c31) (adj c31 c41)
        (adj c43 c33) (adj c33 c43)
        (adj c44 c43) (adj c43 c44)
        (adj c44 c45) (adj c45 c44)
        (adj c45 c35) (adj c35 c45)

        (adj c51 c41) (adj c41 c51)
        (adj c51 c52) (adj c52 c51)
        (adj c52 c53) (adj c53 c52)
        (adj c53 c54) (adj c54 c53)
        (adj c54 c55) (adj c55 c54)
        (adj c54 c44) (adj c44 c54)
        (adj c55 c56) (adj c56 c55)
        (adj c55 c45) (adj c45 c55)

        (adj c61 c51) (adj c51 c61)
        (adj c63 c53) (adj c53 c63)
        (adj c66 c56) (adj c56 c66)

        (primer-dispensar pkg2)      ; pkg2 ha de ser el primer
        (seg-dispensar pkg2 pkg3)    ; pkg3 va just després de pkg2
        (cap-dispensat)              ; encara no s'ha dispensat res
    )

    (:goal (and
        (dispensat pkg2)
        (dispensat pkg3)
        (not (dispensat pkg1))   ; pkg1 contaminat: MAI dispensat
    ))
)