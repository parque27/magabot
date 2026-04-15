(define (domain magabot-avancat-strips)
    (:requirements :strips :typing :negative-preconditions :numeric-fluents)

    (:types
        robot
        paquet
        casella
    )

    (:predicates
        (lliure ?c - casella)
        (adj ?c1 ?c2 - casella)
        (estanteria ?c - casella)
        (dispensador ?c - casella)
        (carregador ?c - casella)

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

    (:functions
        (pes ?p - paquet)
        (energia ?r - robot)
        (max-energia ?r - robot)
        (carrega-actual ?r - robot)
        (max-carrega ?r - robot)
        (energia-total)
    )

    ; ── MOURE ──
    (:action moure-robot-lleuger
        :parameters (?r - robot ?origen - casella ?desti - casella)
        :precondition (and
            (robot-a ?r ?origen)
            (adj ?origen ?desti)
            (lliure ?desti)
            (not (estanteria ?desti))
            (not (dispensador ?desti))
            (not (carregador ?desti))
            (< (carrega-actual ?r) 5)
            (>= (energia ?r) 2)
        )
        :effect (and
            (robot-a ?r ?desti)
            (lliure ?origen)
            (not (robot-a ?r ?origen))
            (not (lliure ?desti))
            (decrease (energia ?r) 2)
            (increase (energia-total) 2)
        )
    )

    (:action moure-robot-pesat
        :parameters (?r - robot ?origen - casella ?desti - casella)
        :precondition (and
            (robot-a ?r ?origen)
            (adj ?origen ?desti)
            (lliure ?desti)
            (not (estanteria ?desti))
            (not (dispensador ?desti))
            (not (carregador ?desti))
            (>= (carrega-actual ?r) 5)
            (>= (energia ?r) 3)
        )
        :effect (and
            (robot-a ?r ?desti)
            (lliure ?origen)
            (not (robot-a ?r ?origen))
            (not (lliure ?desti))
            (decrease (energia ?r) 3)
            (increase (energia-total) 3)
        )
    )

    ; ── RECARREGAR ──
    ; Eliminada la precondició (> energia 0): un robot a 0 també ha de poder recarregar
    ; Afegit cost a energia-total per evitar bucles infinits d'exploració
    (:action recarregar
    :parameters (?r - robot ?c - casella ?carreg - casella)
    :precondition (and
        (robot-a ?r ?c)
        (adj ?c ?carreg)
        (carregador ?carreg)
        (< (energia ?r) (max-energia ?r))
        (<= (+ (energia ?r) 20) (max-energia ?r))
    )
    :effect (and
        (increase (energia ?r) 20)
    )
)

    ; ── AGAFAR ──
    (:action agafar-paquet-buit-estanteria-unitaria
        :parameters (?r - robot ?c - casella ?e - casella ?p - paquet)
        :precondition (and
            (>= (energia ?r) 1)
            (robot-buit ?r)
            (robot-a ?r ?c)
            (adj ?c ?e)
            (estanteria ?e)
            (cim-estanteria ?p ?e)
            (not (sobre-paquet ?p ?p))
            (<= (+ (carrega-actual ?r) (pes ?p)) (max-carrega ?r))
        )
        :effect (and
            (not (robot-buit ?r))
            (cim-robot ?p ?r)
            (not (cim-estanteria ?p ?e))
            (increase (carrega-actual ?r) (pes ?p))
        )
    )

    (:action agafar-paquet-buit-estanteria-pila
        :parameters (?r - robot ?c - casella ?e - casella ?p - paquet ?q - paquet)
        :precondition (and
            (>= (energia ?r) 1)
            (robot-buit ?r)
            (robot-a ?r ?c)
            (adj ?c ?e)
            (estanteria ?e)
            (cim-estanteria ?p ?e)
            (sobre-paquet ?p ?q)
            (<= (+ (carrega-actual ?r) (pes ?p)) (max-carrega ?r))
        )
        :effect (and
            (not (robot-buit ?r))
            (cim-robot ?p ?r)
            (not (cim-estanteria ?p ?e))
            (cim-estanteria ?q ?e)
            (increase (carrega-actual ?r) (pes ?p))
        )
    )

    (:action agafar-paquet-pila-estanteria-unitaria
        :parameters (?r - robot ?c - casella ?e - casella ?p - paquet ?q - paquet)
        :precondition (and
            (>= (energia ?r) 1)
            (not (robot-buit ?r))
            (cim-robot ?p ?r)
            (robot-a ?r ?c)
            (adj ?c ?e)
            (estanteria ?e)
            (cim-estanteria ?q ?e)
            (not (sobre-paquet ?q ?p))
            (<= (+ (carrega-actual ?r) (pes ?q)) (max-carrega ?r))
        )
        :effect (and
            (cim-robot ?q ?r)
            (sobre-paquet ?q ?p)
            (not (cim-robot ?p ?r))
            (not (cim-estanteria ?q ?e))
            (increase (carrega-actual ?r) (pes ?q))
        )
    )

    (:action agafar-paquet-pila-estanteria-pila
        :parameters (?r - robot ?c - casella ?e - casella ?p - paquet ?q - paquet ?t - paquet)
        :precondition (and
            (>= (energia ?r) 1)
            (not (robot-buit ?r))
            (cim-robot ?p ?r)
            (robot-a ?r ?c)
            (adj ?c ?e)
            (estanteria ?e)
            (cim-estanteria ?q ?e)
            (sobre-paquet ?q ?t)
            (<= (+ (carrega-actual ?r) (pes ?q)) (max-carrega ?r))
        )
        :effect (and
            (cim-robot ?q ?r)
            (sobre-paquet ?q ?p)
            (not (cim-robot ?p ?r))
            (not (cim-estanteria ?q ?e))
            (cim-estanteria ?t ?e)
            (increase (carrega-actual ?r) (pes ?q))
        )
    )

    ; ── DESCARREGAR ──
    (:action descarregar-paquet-unic-estanteria-buida
        :parameters (?r - robot ?c - casella ?e - casella ?p - paquet)
        :precondition (and
            (>= (energia ?r) 1)
            (cim-robot ?p ?r)
            (robot-buit ?r)
            (robot-a ?r ?c)
            (adj ?c ?e)
            (estanteria ?e)
            (not (cim-estanteria ?p ?e))
        )
        :effect (and
            (not (cim-robot ?p ?r))
            (robot-buit ?r)
            (cim-estanteria ?p ?e)
            (decrease (carrega-actual ?r) (pes ?p))
        )
    )

    (:action descarregar-paquet-unic-estanteria-pila
        :parameters (?r - robot ?c - casella ?e - casella ?p - paquet ?q - paquet)
        :precondition (and
            (>= (energia ?r) 1)
            (cim-robot ?p ?r)
            (robot-buit ?r)
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
            (decrease (carrega-actual ?r) (pes ?p))
        )
    )

    (:action descarregar-paquet-pila-estanteria-buida
        :parameters (?r - robot ?c - casella ?e - casella ?p - paquet ?q - paquet)
        :precondition (and
            (>= (energia ?r) 1)
            (cim-robot ?p ?r)
            (sobre-paquet ?p ?q)
            (robot-a ?r ?c)
            (adj ?c ?e)
            (estanteria ?e)
            (not (cim-estanteria ?p ?e))
        )
        :effect (and
            (not (cim-robot ?p ?r))
            (not (sobre-paquet ?p ?q))
            (cim-robot ?q ?r)
            (cim-estanteria ?p ?e)
            (decrease (carrega-actual ?r) (pes ?p))
        )
    )

    (:action descarregar-paquet-pila-estanteria-pila
        :parameters (?r - robot ?c - casella ?e - casella ?p - paquet ?q - paquet ?t - paquet)
        :precondition (and
            (>= (energia ?r) 1)
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
            (decrease (carrega-actual ?r) (pes ?p))
        )
    )

    ; ── DISPENSAR ──
    (:action dispensar-paquet-unic
        :parameters (?p - paquet ?r - robot ?c - casella ?d - casella)
        :precondition (and
            (>= (energia ?r) 1)
            (not (dispensat ?p))
            (cim-robot ?p ?r)
            (robot-buit ?r)
            (robot-a ?r ?c)
            (adj ?c ?d)
            (dispensador ?d)
        )
        :effect (and
            (dispensat ?p)
            (not (cim-robot ?p ?r))
            (robot-buit ?r)
            (decrease (carrega-actual ?r) (pes ?p))
        )
    )

    (:action dispensar-paquet-pila
        :parameters (?p - paquet ?q - paquet ?r - robot ?c - casella ?d - casella)
        :precondition (and
            (>= (energia ?r) 1)
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
            (decrease (carrega-actual ?r) (pes ?p))
        )
    )

    ; ── DISPENSAR AMB ORDRE ──
    (:action dispensar-ordre-primer-unic
        :parameters (?p - paquet ?r - robot ?c - casella ?d - casella)
        :precondition (and
            (>= (energia ?r) 1)
            (primer-dispensar ?p)
            (cap-dispensat)
            (not (dispensat ?p))
            (cim-robot ?p ?r)
            (robot-buit ?r)
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
            (decrease (carrega-actual ?r) (pes ?p))
        )
    )

    (:action dispensar-ordre-primer-pila
        :parameters (?p - paquet ?q - paquet ?r - robot ?c - casella ?d - casella)
        :precondition (and
            (>= (energia ?r) 1)
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
            (decrease (carrega-actual ?r) (pes ?p))
        )
    )

    (:action dispensar-ordre-seg-unic
        :parameters (?prev - paquet ?p - paquet ?r - robot ?c - casella ?d - casella)
        :precondition (and
            (>= (energia ?r) 1)
            (seg-dispensar ?prev ?p)
            (darrer-dispensat ?prev)
            (not (dispensat ?p))
            (cim-robot ?p ?r)
            (robot-buit ?r)
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
            (decrease (carrega-actual ?r) (pes ?p))
        )
    )

    (:action dispensar-ordre-seg-pila
        :parameters (?prev - paquet ?p - paquet ?q - paquet ?r - robot ?c - casella ?d - casella)
        :precondition (and
            (>= (energia ?r) 1)
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
            (decrease (carrega-actual ?r) (pes ?p))
        )
    )
)