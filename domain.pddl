(define (domain magabot-strips)

    (:requirements :strips :typing :negative-preconditions)

    (:types
        robot
        paquet
        casella
    )

    (:predicates
        ; Casella
        (lliure ?c - casella)               ; no hi ha cap robot a c
        (adj ?c1 ?c2 - casella)             ; c1 és adjacent a c2
        (estanteria ?c - casella)           ; c és una estanteria
        (dispensador ?c - casella)          ; c és un dispensador espacial

        ; Robot
        (robot-a ?r - robot ?c - casella)   ; el robot r és a la casella c
        (robot-buit ?r - robot)             ; el robot r no porta cap paquet

        ; Piles
        (sobre-paquet ?p1 ?p2 - paquet)     ; p1 és directament sobre p2
        (cim-estanteria ?p - paquet ?e - casella) ; p és el paquet de dalt de l'estanteria e
        (cim-robot ?p - paquet ?r - robot)  ; p és el paquet de dalt del robot r

        ; Dispensació
        (dispensat ?p - paquet)             ; p ha estat dispensat correctament
    )

    ; ── MOURE ──────────────────────────────────────────────────────────────
    (:action moure-robot
        :parameters (?r - robot ?origen - casella ?desti - casella)
        :precondition (and
            (robot-a ?r ?origen)
            (adj ?origen ?desti)
            (lliure ?desti)
            (not (estanteria ?desti))
            (not (dispensador ?desti))
        )
        :effect (and
            (robot-a ?r ?desti)
            (lliure ?origen)
            (not (robot-a ?r ?origen))
            (not (lliure ?desti))
        )
    )

    ; ── AGAFAR ─────────────────────────────────────────────────────────────
    ; Robot buit, estanteria amb un sol paquet (queda buida)
    (:action agafar-paquet-buit-estanteria-unitaria
        :parameters (?r - robot ?c - casella ?e - casella ?p - paquet)
        :precondition (and
            (robot-buit ?r)
            (robot-a ?r ?c)
            (adj ?c ?e)
            (estanteria ?e)
            (cim-estanteria ?p ?e)
            ; no hi ha res a sota: cap acció trobarà ?q vàlid sense sobre-paquet
        )
        :effect (and
            (not (robot-buit ?r))
            (cim-robot ?p ?r)
            (not (cim-estanteria ?p ?e))
        )
    )

    ; Robot buit, estanteria amb més d'un paquet
    (:action agafar-paquet-buit-estanteria-pila
        :parameters (?r - robot ?c - casella ?e - casella ?p - paquet ?q - paquet)
        :precondition (and
            (robot-buit ?r)
            (robot-a ?r ?c)
            (adj ?c ?e)
            (estanteria ?e)
            (cim-estanteria ?p ?e)
            (sobre-paquet ?p ?q)            ; q és just a sota de p
        )
        :effect (and
            (not (robot-buit ?r))
            (cim-robot ?p ?r)
            (not (cim-estanteria ?p ?e))
            (cim-estanteria ?q ?e)          ; q és el nou cim
        )
    )

    ; Robot amb pila, estanteria amb un sol paquet (queda buida)
    (:action agafar-paquet-pila-estanteria-unitaria
        :parameters (?r - robot ?c - casella ?e - casella ?p - paquet ?q - paquet)
        :precondition (and
            (not (robot-buit ?r))
            (cim-robot ?p ?r)               ; p és el cim del robot
            (robot-a ?r ?c)
            (adj ?c ?e)
            (estanteria ?e)
            (cim-estanteria ?q ?e)          ; q és l'únic paquet de l'estanteria
        )
        :effect (and
            (cim-robot ?q ?r)               ; q és el nou cim del robot
            (sobre-paquet ?q ?p)            ; q queda sobre p
            (not (cim-robot ?p ?r))
            (not (cim-estanteria ?q ?e))
        )
    )

    ; Robot amb pila, estanteria amb més d'un paquet
    (:action agafar-paquet-pila-estanteria-pila
        :parameters (?r - robot ?c - casella ?e - casella ?p - paquet ?q - paquet ?t - paquet)
        :precondition (and
            (not (robot-buit ?r))
            (cim-robot ?p ?r)
            (robot-a ?r ?c)
            (adj ?c ?e)
            (estanteria ?e)
            (cim-estanteria ?q ?e)
            (sobre-paquet ?q ?t)            ; t és just a sota de q
        )
        :effect (and
            (cim-robot ?q ?r)
            (sobre-paquet ?q ?p)
            (not (cim-robot ?p ?r))
            (not (cim-estanteria ?q ?e))
            (cim-estanteria ?t ?e)          ; t és el nou cim
        )
    )

    ; ── DESCARREGAR ────────────────────────────────────────────────────────
    ; Robot amb un sol paquet, estanteria buida
    (:action descarregar-paquet-unic-estanteria-buida
        :parameters (?r - robot ?c - casella ?e - casella ?p - paquet)
        :precondition (and
            (cim-robot ?p ?r)
            (robot-a ?r ?c)
            (adj ?c ?e)
            (estanteria ?e)
            (not (cim-estanteria ?p ?e))    ; no hi ha cap paquet a l'estanteria
        )
        :effect (and
            (not (cim-robot ?p ?r))
            (robot-buit ?r)
            (cim-estanteria ?p ?e)
        )
    )

    ; Robot amb un sol paquet, estanteria amb pila
    (:action descarregar-paquet-unic-estanteria-pila
        :parameters (?r - robot ?c - casella ?e - casella ?p - paquet ?q - paquet)
        :precondition (and
            (cim-robot ?p ?r)
            (robot-a ?r ?c)
            (adj ?c ?e)
            (estanteria ?e)
            (cim-estanteria ?q ?e)          ; q és el cim actual
        )
        :effect (and
            (not (cim-robot ?p ?r))
            (robot-buit ?r)
            (cim-estanteria ?p ?e)
            (not (cim-estanteria ?q ?e))
            (sobre-paquet ?p ?q)
        )
    )

    ; Robot amb pila, estanteria buida
    (:action descarregar-paquet-pila-estanteria-buida
        :parameters (?r - robot ?c - casella ?e - casella ?p - paquet ?q - paquet)
        :precondition (and
            (cim-robot ?p ?r)
            (sobre-paquet ?p ?q)            ; q és just a sota de p
            (robot-a ?r ?c)
            (adj ?c ?e)
            (estanteria ?e)
            (not (cim-estanteria ?p ?e))    ; no hi ha cap paquet a l'estanteria
        )
        :effect (and
            (not (cim-robot ?p ?r))
            (not (sobre-paquet ?p ?q))
            (cim-robot ?q ?r)               ; q és el nou cim del robot
            (cim-estanteria ?p ?e)
        )
    )

    ; Robot amb pila, estanteria amb pila
    (:action descarregar-paquet-pila-estanteria-pila
        :parameters (?r - robot ?c - casella ?e - casella ?p - paquet ?q - paquet ?t - paquet)
        :precondition (and
            (cim-robot ?p ?r)
            (sobre-paquet ?p ?q)
            (robot-a ?r ?c)
            (adj ?c ?e)
            (estanteria ?e)
            (cim-estanteria ?t ?e)          ; t és el cim actual
        )
        :effect (and
            (not (cim-robot ?p ?r))
            (not (sobre-paquet ?p ?q))
            (cim-robot ?q ?r)
            (cim-estanteria ?p ?e)
            (not (cim-estanteria ?t ?e))
            (sobre-paquet ?p ?t)
        )
    )

    ; ── DISPENSAR ──────────────────────────────────────────────────────────
    ; Robot amb un sol paquet
    (:action dispensar-paquet-unic
        :parameters (?p - paquet ?r - robot ?c - casella ?d - casella)
        :precondition (and
            (not (dispensat ?p))
            (cim-robot ?p ?r)
            (robot-a ?r ?c)
            (adj ?c ?d)
            (dispensador ?d)
        )
        :effect (and
            (dispensat ?p)
            (not (cim-robot ?p ?r))
            (robot-buit ?r)
        )
    )

    ; Robot amb pila
    (:action dispensar-paquet-pila
        :parameters (?p - paquet ?q - paquet ?r - robot ?c - casella ?d - casella)
        :precondition (and
            (not (dispensat ?p))
            (cim-robot ?p ?r)
            (sobre-paquet ?p ?q)            ; q és just a sota de p
            (robot-a ?r ?c)
            (adj ?c ?d)
            (dispensador ?d)
        )
        :effect (and
            (dispensat ?p)
            (not (cim-robot ?p ?r))
            (not (sobre-paquet ?p ?q))
            (cim-robot ?q ?r)               ; q és el nou cim del robot
        )
    )
)