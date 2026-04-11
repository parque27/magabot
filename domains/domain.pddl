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
        (robot-buit ?r - robot)

        ; Pila
        (sobre-paquet ?p1 ?p2 - paquet)
        (estanteria-buida ?e - casella) 
        (cim-estanteria ?p - paquet ?e - casella)
        (cim-robot ?p - paquet ?r - robot)
        (dispensat ?p - paquet) 

    )

    ; Funcions
    (:functions
        ; no cal aqui
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
    ; El robot està buit, l'estanteria té un sol paquet (queda buida)
    (:action agafar-paquet-buit-estanteria-unitaria
        :parameters (
            ?r - robot
            ?c - casella
            ?e - casella
            ?p - paquet
        )
        :precondition (and 
            (robot-buit ?r)                 ; el robot està buit
            (robot-a ?r ?c)                 ; el robot està a la casella c
            (adj ?c ?e)                     ; c és adjacent a l'estanteria e
            (estanteria ?e)                 ; e és una estanteria
            (cim-estanteria ?p ?e)          ; p és el cim de l'estanteria e
            (not (estanteria-buida ?e))     ; e no és buida
        )
        :effect (and 
            (not (robot-buit ?r))           ; el robot ja no és buit
            (cim-robot ?p ?r)               ; p és el nou cim del robot
            (not (cim-estanteria ?p ?e))    ; p ja no és al cim de l'estanteria
            (estanteria-buida ?e)           ; l'estanteria queda buida
        )
    )

    ; El robot està buit, l'estanteria té més d'un paquet
    (:action agafar-paquet-buit-estanteria-pila
        :parameters (
            ?r - robot
            ?c - casella
            ?e - casella
            ?p - paquet
            ?q - paquet
        )
        :precondition (and 
            (robot-buit ?r)                 ; el robot està buit
            (robot-a ?r ?c)                 ; el robot està a la casella c
            (adj ?c ?e)                     ; c és adjacent a l'estanteria e
            (estanteria ?e)                 ; e és una estanteria
            (cim-estanteria ?p ?e)          ; p és el cim de l'estanteria e
            (sobre-paquet ?p ?q)            ; q és el paquet just a sota de p
        )
        :effect (and 
            (not (robot-buit ?r))           ; el robot ja no és buit
            (cim-robot ?p ?r)               ; p és el nou cim del robot
            (not (cim-estanteria ?p ?e))    ; p ja no és al cim de l'estanteria
            (cim-estanteria ?q ?e)          ; q és el nou cim de l'estanteria
        )
    )

    ; El robot porta paquets, l'estanteria té un sol paquet (queda buida)
    (:action agafar-paquet-pila-estanteria-unitaria
        :parameters (
            ?r - robot
            ?c - casella
            ?e - casella
            ?p - paquet                     ; paquet al cim del robot
            ?q - paquet                     ; paquet al cim de l'estanteria
        )
        :precondition (and 
            (not (robot-buit ?r))           ; el robot NO és buit
            (cim-robot ?p ?r)               ; p és el cim del robot
            (robot-a ?r ?c)                 ; el robot està a la casella c
            (adj ?c ?e)                     ; c és adjacent a l'estanteria e
            (estanteria ?e)                 ; e és una estanteria
            (cim-estanteria ?q ?e)          ; q és el cim de l'estanteria e
            (not (estanteria-buida ?e))     ; e no és buida
        )
        :effect (and 
            (cim-robot ?q ?r)               ; q és el nou cim del robot
            (sobre-paquet ?q ?p)            ; q queda sobre p a la pila del robot
            (not (cim-robot ?p ?r))         ; p ja no és el cim del robot
            (not (cim-estanteria ?q ?e))    ; q ja no és al cim de l'estanteria
            (estanteria-buida ?e)           ; l'estanteria queda buida
        )
    )

    ; El robot porta paquets, l'estanteria té més d'un paquet
    (:action agafar-paquet-pila-estanteria-pila
        :parameters (
            ?r - robot
            ?c - casella
            ?e - casella
            ?p - paquet                     ; paquet al cim del robot
            ?q - paquet                     ; paquet al cim de l'estanteria
            ?t - paquet                     ; paquet just a sota de q a l'estanteria
        )
        :precondition (and 
            (not (robot-buit ?r))           ; el robot NO és buit
            (cim-robot ?p ?r)               ; p és el cim del robot
            (robot-a ?r ?c)                 ; el robot està a la casella c
            (adj ?c ?e)                     ; c és adjacent a l'estanteria e
            (estanteria ?e)                 ; e és una estanteria
            (cim-estanteria ?q ?e)          ; q és el cim de l'estanteria e
            (sobre-paquet ?q ?t)            ; t és el paquet just a sota de q
        )
        :effect (and 
            (cim-robot ?q ?r)               ; q és el nou cim del robot
            (sobre-paquet ?q ?p)            ; q queda sobre p a la pila del robot
            (not (cim-robot ?p ?r))         ; p ja no és el cim del robot
            (not (cim-estanteria ?q ?e))    ; q ja no és al cim de l'estanteria
            (cim-estanteria ?t ?e)          ; t és el nou cim de l'estanteria
        )
    )
; Robot amb un sol paquet, estanteria buida
    (:action descarregar-paquet-unic-estanteria-buida
        :parameters (
            ?r - robot
            ?c - casella
            ?e - casella
            ?p - paquet
        )
        :precondition (and 
            (cim-robot ?p ?r)               ; p és el cim del robot
            (robot-a ?r ?c)                 ; el robot està a la casella c
            (adj ?c ?e)                     ; c és adjacent a l'estanteria e
            (estanteria ?e)                 ; e és una estanteria
            (estanteria-buida ?e)           ; l'estanteria és buida
        )
        :effect (and 
            (not (cim-robot ?p ?r))         ; p ja no és al cim del robot
            (robot-buit ?r)                 ; el robot queda buit
            (cim-estanteria ?p ?e)          ; p és el nou cim de l'estanteria
            (not (estanteria-buida ?e))     ; l'estanteria ja no és buida
        )
    )

    ; Robot amb un sol paquet, estanteria amb pila
    (:action descarregar-paquet-unic-estanteria-pila
        :parameters (
            ?r - robot
            ?c - casella
            ?e - casella
            ?p - paquet                     ; paquet al cim del robot
            ?q - paquet                     ; paquet al cim de l'estanteria
        )
        :precondition (and 
            (cim-robot ?p ?r)               ; p és el cim del robot
            (robot-a ?r ?c)                 ; el robot està a la casella c
            (adj ?c ?e)                     ; c és adjacent a l'estanteria e
            (estanteria ?e)                 ; e és una estanteria
            (cim-estanteria ?q ?e)          ; q és el cim actual de l'estanteria
        )
        :effect (and 
            (not (cim-robot ?p ?r))         ; p ja no és al cim del robot
            (robot-buit ?r)                 ; el robot queda buit
            (cim-estanteria ?p ?e)          ; p és el nou cim de l'estanteria
            (not (cim-estanteria ?q ?e))    ; q ja no és el cim
            (sobre-paquet ?p ?q)            ; p queda sobre q
        )
    )

    ; Robot amb pila, estanteria buida
    (:action descarregar-paquet-pila-estanteria-buida
        :parameters (
            ?r - robot
            ?c - casella
            ?e - casella
            ?p - paquet                     ; paquet al cim del robot
            ?q - paquet                     ; paquet just a sota de p al robot
        )
        :precondition (and 
            (cim-robot ?p ?r)               ; p és el cim del robot
            (sobre-paquet ?p ?q)            ; q és just a sota de p al robot
            (robot-a ?r ?c)                 ; el robot està a la casella c
            (adj ?c ?e)                     ; c és adjacent a l'estanteria e
            (estanteria ?e)                 ; e és una estanteria
            (estanteria-buida ?e)           ; l'estanteria és buida
        )
        :effect (and 
            (not (cim-robot ?p ?r))         ; p ja no és al cim del robot
            (not (sobre-paquet ?p ?q))      ; p ja no és sobre q
            (cim-robot ?q ?r)               ; q és el nou cim del robot
            (cim-estanteria ?p ?e)          ; p és el nou cim de l'estanteria
            (not (estanteria-buida ?e))     ; l'estanteria ja no és buida
        )
    )

    ; Robot amb pila, estanteria amb pila
    (:action descarregar-paquet-pila-estanteria-pila
        :parameters (
            ?r - robot
            ?c - casella
            ?e - casella
            ?p - paquet                     ; paquet al cim del robot
            ?q - paquet                     ; paquet just a sota de p al robot
            ?t - paquet                     ; paquet al cim de l'estanteria
        )
        :precondition (and 
            (cim-robot ?p ?r)               ; p és el cim del robot
            (sobre-paquet ?p ?q)            ; q és just a sota de p al robot
            (robot-a ?r ?c)                 ; el robot està a la casella c
            (adj ?c ?e)                     ; c és adjacent a l'estanteria e
            (estanteria ?e)                 ; e és una estanteria
            (cim-estanteria ?t ?e)          ; t és el cim actual de l'estanteria
        )
        :effect (and 
            (not (cim-robot ?p ?r))         ; p ja no és al cim del robot
            (not (sobre-paquet ?p ?q))      ; p ja no és sobre q al robot
            (cim-robot ?q ?r)               ; q és el nou cim del robot
            (cim-estanteria ?p ?e)          ; p és el nou cim de l'estanteria
            (not (cim-estanteria ?t ?e))    ; t ja no és el cim
            (sobre-paquet ?p ?t)            ; p queda sobre t a l'estanteria
        )
    )
    (:action dispensar-paquet-unic
        :parameters (
            ?p - paquet
            ?r - robot
            ?c - casella
            ?d - casella
        )
        :precondition (and 
            (not (dispensat ?p))
            (cim-robot ?p ?r)
            (not (robot-buit ?r)) ; cal?
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
    (:action dispensar-paquet-pila
        :parameters (
            ?p - paquet
            ?q - paquet
            ?r - robot
            ?c - casella
            ?d - casella
        )
        :precondition (and 
            (cim-robot ?p ?r)
            (sobre-paquet ?p ?q)
            (not (robot-buit ?r)) ; cal?
            (robot-a ?r ?c)
            (adj ?c ?d)
            (dispensador ?d)
        )
        :effect (and 
            (not (cim-robot ?p ?r))
            (not (sobre-paquet ?p ?q))
            (dispensat ?p)
            (cim-robot ?q ?r)
        )
    )
)