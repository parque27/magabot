;Header and description
(define (domain magabot-strips)

    ; Requeriments
    (:requirements :strips :typing :negative-preconditions)

    ; Tipus
    (:types
        robot
        paquet
        casella
    )

    ; Predicats
    (:predicates
        ; Casella
        (lliure ?c - casella)
        (adj ?c1 ?c2 - casella)
        (estanteria ?c - casella)
        (dispensador ?c - casella)

        ; Robot
        (robot-a ?r - robot ?c - casella)

        ; Pila
        (sobre-paquet ?p1 ?p2 - paquet)
        (sobre-estanteria ?p - paquet ?c - casella)
        (sobre-robot ?p - paquet ?r - robot)

    )

    ; Funcions
    (:functions
        
    )

    ; Accions
    (:action moure-robot
        :parameters (
            ?r - robot
            ?origen - casella
            ?desti - casella
        )
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
    (:action agafar-paquet
        :parameters ()
        :precondition (and )
        :effect (and )
    )
    (:action descarregar-paquet
        :parameters ()
        :precondition (and )
        :effect (and )
    )
    (:action recarregar-bateria
        :parameters ()
        :precondition (and )
        :effect (and )
    )
    (:action dispensar-paquet
        :parameters ()
        :precondition (and )
        :effect (and )
    )
)