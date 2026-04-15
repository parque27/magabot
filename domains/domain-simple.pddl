(define (domain magabot-strips)

    (:requirements :strips :typing :negative-preconditions)

    (:types robot paquet casella)

    (:predicates
        (lliure ?c - casella)
        (adj ?c1 ?c2 - casella)
        (estanteria ?c - casella)
        (dispensador ?c - casella)
        (robot-a ?r - robot ?c - casella)
        (robot-buit ?r - robot)
        (sobre-paquet ?p1 ?p2 - paquet)
        (cim-estanteria ?p - paquet ?e - casella)
        (cim-robot ?p - paquet ?r - robot)
        (dispensat ?p - paquet)
        (primer-dispensar ?p - paquet)
        (seg-dispensar ?p1 ?p2 - paquet)
        (cap-dispensat)
        (darrer-dispensat ?p - paquet)
    )

    ; MOURE
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

    ; AGAFAR — robot buit, estanteria amb un paquet (queda buida)
    (:action agafar-buit-unitaria
        :parameters (?r - robot ?c - casella ?e - casella ?p - paquet)
        :precondition (and
            (robot-buit ?r)
            (robot-a ?r ?c)
            (adj ?c ?e)
            (estanteria ?e)
            (cim-estanteria ?p ?e)
        )
        :effect (and
            (not (robot-buit ?r))
            (cim-robot ?p ?r)
            (not (cim-estanteria ?p ?e))
        )
    )

    ; AGAFAR — robot buit, estanteria amb pila (q sota p)
    (:action agafar-buit-pila
        :parameters (?r - robot ?c - casella ?e - casella ?p - paquet ?q - paquet)
        :precondition (and
            (robot-buit ?r)
            (robot-a ?r ?c)
            (adj ?c ?e)
            (estanteria ?e)
            (cim-estanteria ?p ?e)
            (sobre-paquet ?p ?q)
        )
        :effect (and
            (not (robot-buit ?r))
            (cim-robot ?p ?r)
            (not (cim-estanteria ?p ?e))
            (cim-estanteria ?q ?e)
        )
    )

    ; AGAFAR — robot amb pila, estanteria amb un paquet (queda buida)
    (:action agafar-pila-unitaria
        :parameters (?r - robot ?c - casella ?e - casella ?p - paquet ?q - paquet)
        :precondition (and
            (not (robot-buit ?r))
            (cim-robot ?p ?r)
            (robot-a ?r ?c)
            (adj ?c ?e)
            (estanteria ?e)
            (cim-estanteria ?q ?e)
        )
        :effect (and
            (cim-robot ?q ?r)
            (sobre-paquet ?q ?p)
            (not (cim-robot ?p ?r))
            (not (cim-estanteria ?q ?e))
        )
    )

    ; AGAFAR — robot amb pila, estanteria amb pila (t sota q)
    (:action agafar-pila-pila
        :parameters (?r - robot ?c - casella ?e - casella ?p - paquet ?q - paquet ?t - paquet)
        :precondition (and
            (not (robot-buit ?r))
            (cim-robot ?p ?r)
            (robot-a ?r ?c)
            (adj ?c ?e)
            (estanteria ?e)
            (cim-estanteria ?q ?e)
            (sobre-paquet ?q ?t)
        )
        :effect (and
            (cim-robot ?q ?r)
            (sobre-paquet ?q ?p)
            (not (cim-robot ?p ?r))
            (not (cim-estanteria ?q ?e))
            (cim-estanteria ?t ?e)
        )
    )

    ; DESCARREGAR — robot amb un paquet, estanteria buida
    (:action descarregar-unic-buida
        :parameters (?r - robot ?c - casella ?e - casella ?p - paquet)
        :precondition (and
            (cim-robot ?p ?r)
            (robot-a ?r ?c)
            (adj ?c ?e)
            (estanteria ?e)
        )
        :effect (and
            (not (cim-robot ?p ?r))
            (robot-buit ?r)
            (cim-estanteria ?p ?e)
        )
    )

    ; DESCARREGAR — robot amb un paquet, estanteria amb pila (q és cim)
    (:action descarregar-unic-pila
        :parameters (?r - robot ?c - casella ?e - casella ?p - paquet ?q - paquet)
        :precondition (and
            (cim-robot ?p ?r)
            (robot-a ?r ?c)
            (adj ?c ?e)
            (estanteria ?e)
            (cim-estanteria ?q ?e)
            (not (sobre-paquet ?p ?q))
        )
        :effect (and
            (not (cim-robot ?p ?r))
            (robot-buit ?r)
            (cim-estanteria ?p ?e)
            (not (cim-estanteria ?q ?e))
            (sobre-paquet ?p ?q)
        )
    )

    ; DESCARREGAR — robot amb pila (q sota p), estanteria buida
    (:action descarregar-pila-buida
        :parameters (?r - robot ?c - casella ?e - casella ?p - paquet ?q - paquet)
        :precondition (and
            (cim-robot ?p ?r)
            (sobre-paquet ?p ?q)
            (robot-a ?r ?c)
            (adj ?c ?e)
            (estanteria ?e)
        )
        :effect (and
            (not (cim-robot ?p ?r))
            (not (sobre-paquet ?p ?q))
            (cim-robot ?q ?r)
            (cim-estanteria ?p ?e)
        )
    )

    ; DESCARREGAR — robot amb pila (q sota p), estanteria amb pila (t és cim)
    (:action descarregar-pila-pila
        :parameters (?r - robot ?c - casella ?e - casella ?p - paquet ?q - paquet ?t - paquet)
        :precondition (and
            (cim-robot ?p ?r)
            (sobre-paquet ?p ?q)
            (robot-a ?r ?c)
            (adj ?c ?e)
            (estanteria ?e)
            (cim-estanteria ?t ?e)
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

    ; DISPENSAR (sense ordre) — robot amb un paquet
    (:action dispensar-unic
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

    ; DISPENSAR (sense ordre) — robot amb pila (q sota p)
    (:action dispensar-pila
        :parameters (?p - paquet ?q - paquet ?r - robot ?c - casella ?d - casella)
        :precondition (and
            (not (dispensat ?p))
            (cim-robot ?p ?r)
            (sobre-paquet ?p ?q)
            (robot-a ?r ?c)
            (adj ?c ?d)
            (dispensador ?d)
        )
        :effect (and
            (dispensat ?p)
            (not (cim-robot ?p ?r))
            (not (sobre-paquet ?p ?q))
            (cim-robot ?q ?r)
        )
    )

    ; DISPENSAR ORDENAT — primer paquet, robot amb un paquet
    (:action dispensar-ordre-primer-unic
        :parameters (?p - paquet ?r - robot ?c - casella ?d - casella)
        :precondition (and
            (primer-dispensar ?p)
            (cap-dispensat)
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
            (not (cap-dispensat))
            (darrer-dispensat ?p)
        )
    )

    ; DISPENSAR ORDENAT — primer paquet, robot amb pila
    (:action dispensar-ordre-primer-pila
        :parameters (?p - paquet ?q - paquet ?r - robot ?c - casella ?d - casella)
        :precondition (and
            (primer-dispensar ?p)
            (cap-dispensat)
            (not (dispensat ?p))
            (cim-robot ?p ?r)
            (sobre-paquet ?p ?q)
            (robot-a ?r ?c)
            (adj ?c ?d)
            (dispensador ?d)
        )
        :effect (and
            (dispensat ?p)
            (not (cim-robot ?p ?r))
            (not (sobre-paquet ?p ?q))
            (cim-robot ?q ?r)
            (not (cap-dispensat))
            (darrer-dispensat ?p)
        )
    )

    ; DISPENSAR ORDENAT — següent paquet, robot amb un paquet
    (:action dispensar-ordre-seg-unic
        :parameters (?prev - paquet ?p - paquet ?r - robot ?c - casella ?d - casella)
        :precondition (and
            (seg-dispensar ?prev ?p)
            (darrer-dispensat ?prev)
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
            (not (darrer-dispensat ?prev))
            (darrer-dispensat ?p)
        )
    )

    ; DISPENSAR ORDENAT — següent paquet, robot amb pila
    (:action dispensar-ordre-seg-pila
        :parameters (?prev - paquet ?p - paquet ?q - paquet ?r - robot ?c - casella ?d - casella)
        :precondition (and
            (seg-dispensar ?prev ?p)
            (darrer-dispensat ?prev)
            (not (dispensat ?p))
            (cim-robot ?p ?r)
            (sobre-paquet ?p ?q)
            (robot-a ?r ?c)
            (adj ?c ?d)
            (dispensador ?d)
        )
        :effect (and
            (dispensat ?p)
            (not (cim-robot ?p ?r))
            (not (sobre-paquet ?p ?q))
            (cim-robot ?q ?r)
            (not (darrer-dispensat ?prev))
            (darrer-dispensat ?p)
        )
    )
)