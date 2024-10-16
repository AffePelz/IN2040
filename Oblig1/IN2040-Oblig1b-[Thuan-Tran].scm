;; IN2040-Oblig1b-[Thuan-Tran].scm
;; Oppgave 1a
#|
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
(cons 42 11)
---> (42 . 11)

    +---+---+  
--->| x | x-|--> 11
    +-|-+---+  
      |
      V
     42
Vi får et par her.

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

Oppgave 1b
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
(cons 42 '())
---> (42)

    +---+---+
--->| x | / |
    +-|-+---+
      |
      V
     42
Vi får et par her, men '() er en tom liste så vi har / istedenfor. Strukturen er ekvivalent med (list 42).

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

Oppgave 1c
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
(list 42 11)
---> (42 11)

    +---+---+   +---+---+
--->| x | x-|-->| x | / |
    +-|-+---+   +-|-+---+
      |           |
      V           V
     42          11
Dette er ekvivalent med (cons 42 (cons 11 '())), så vi får et par av 42 og (cons 11 '()), hvor igjen (cons 11 '()) er et par som argumenteres som oppgave 1b.

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

Oppgave 1d
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
'(42 (11 12))
---> (42 (11 12))

    +---+---+  +---+---+
--->| x | x-|->| x | / |
    +-|-+---+  +-|-+---+
      |          |
      V          V
     42        +---+---+  +---+---+
               | x | x-|->| x | / |
               +-|-+---+  +-|-+---+
                 |          |
                 V          V
                11         12

Dette er ekvivalent med (cons 42 (cons (list 11 12) '())), så vi får et par av 42 og (cons (list 11 12) '()), hvor igjen (cons (list 11 12) '()) er et par av (list 11 12) og '().
Igjen så argumenteres (list 11 12) på samme måte som oppgave 1c.

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

Oppgave 1e
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
(define foo '(1 2 3))
(cons foo foo)
---> ((1 2 3) 1 2 3)

    +---+------+
--->| x |   x  |
    +-|-+--/---+
      |   /
      |  /
      V V
    +-----+
    | foo |
    +-----+

Og boks-peker diagrammet for foo ser slik ut
    +---+---+   +---+---+   +---+---+
--->| x | x-|-->| x | x-|-->| x | / |
    +-|-+---+   +-|-+---+   +-|-+---+
      |           |           |
      V           V           V
      1           2           3

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

Oppgave 1f
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
(0 42 #t bar)

Minner om at car velger det første elementet i en liste, mens cdr velger en liste med alle elementene fra listen, bortsett fra det første elementet. Vi kan se at 42 ikke er det
første elementet i listen, så vi må først velge cdr, og får da (42 #t bar). Her er 42 da det første elementet i listen, så vi kan da ta car. Med kombinasjon av bare å bruke car og
cdr, så trekker vi ut elementet 42 slik:

(car (cdr '(0 42 #t bar)))
---> 42
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

Oppgave 1g
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
((0 42) (#t bar))

Denne gangen, så har vi to elementer, (0 42) og (#t bar). Vi kan se at 42 ligger i det første elementet. Derfor må vi bruke car først, for å få (0 42). Her ser vi at 42 er ikke det
første elementet i (0 42). Derfor må vi bruke cdr, men da får vi (42), ikke 42, så vi må bruke car igjen for å hente tallet 42 fra listen. Med kombinasjon av bare car og cdr, så
trekker vi ut elementet 42 slik:

(car (cdr (car '((0 42) (#t bar)))))
---> 42
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

Oppgave 1h
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
((0) (42 #t) (bar))

Denne gangen har vi tre elementer, (0), (42 #t) og (bar). Igjen så bruker vi da cdr for å hente de to siste elementene (fordi 42 ligger ikke i det første elementet), og vi får da
((42 #t) (bar)). Vi ser at 42 ligger i det første elementet. Derfor må vi bruke car for å hente (42 #t). Igjen så er 42 det første elementet av dette elementet. Derfor bruker vi
car igjen. Med kombinasjon av bare car og cdr, så trekker vi ut elementet 42 slik:

(car (car (cdr '((0) (42 #t) (bar)))))
---> 42
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

Oppgave 1i
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
1) Vi skal se om vi kan få den samme listen fra oppgave 1i ved å bare bruke prosedyren cons. Det er to ting vi må huske på.
   (a) (list <a1> <a2> ... <an>) er ekvivalent med (<==>) (cons <a1> (cons <a2> (cons ... (cons <an> '()) ... )))
   (b) Det første argumentet til cons må være en liste, mens det andre argumentet må være en liste inni en liste,
       med andre ord må vi konstruere (cons (list <a1>) (list (list <a2>))), hvor vi i tillegg skal erstatte list med cons ved hjelp av (a).

   Det første argumentet vårt skal være (0 42), så vi bruker (a) og får da (cons 0 (cons 42 '())). Det andre argumentet vårt skal skrives som ((#t bar)). Hvis vi fokuserer på
   innsiden, så bruker vi igjen (a) og får da (cons #t (cons bar '())) --> (#t bar). Så tar vi dette og bruker (a) igjen, og får da

   (cons (cons #t (cons bar '())) '())

   Til slutt setter vi resultatene vi har vist inni (b) og til slutt vil koden da se slik ut:

   (cons (cons 0 (cons 42 '())) (cons (cons #t (cons 'bar '())) '()))
   ---> ((0 42) (#t bar))

2) Vi skal se om vi kan få den samme listen fra oppgave 1i ved å bare bruke prosedyren list. Vi setter da elementene 0 og 42 i en liste og #t og bar i en liste. Da har vi to separate
   lister (list 0 42) og (list #t bar). Igjen så setter vi disse inn i en liste (bruker litt av ideen fra (b)). Til slutt vil koden da se slik ut:

   (list (list 0 42) (list #t bar))
   ---> ((0 42) (#t bar))

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
|#
;; Oppgave 2a
(define (take n items)
  (if (or (null? items) (= n 0))
      '()
      (cons (car items) (take (- n 1) (cdr items)))))
#|
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
Her har vi en rekursiv prosess, hvor vi skal få en lang kjede med cons av første element av (cdr items) og '(). Det er to tilfeller vi må se for at kjeden ender opp med
(cons <ai> '()). Det første tilfellet er når n går mot null. Det hender at vi har noen elementer igjen etter n ganger med (cdr items), så når n går mot 0 så returnerer vi '(). Hvis
vi ikke inkluderer dette, så vil vi bare returnere den samme listen. Det andre tilfellet er når (cdr items) ikke har noen elementer igjen. Det hender at n > 0 når vi ikke har noen
elementer igjen. Når vi har ingen elementer igjen, så returnerer vi '(). Hvis vi ikke inkluderer dette, så vil vi komme til et tilfelle hvor vi har (car '()) og får da en
feilmelding. Derfor må vi ha at (take (- n 1) (cdr items)) returnerer '() dersom ett av tilfellene oppfylles.

Ta eksemplene (take 3 '(a b c d e f)) og (take 4 '(a b)). Prosessene ser da slik ut:
(take 3 '(a b c d e f))
(cons a (take 2 '(b c d e f)))
(cons a (cons b (take 1 '(c d e f))))
(cons a (cons b (cons c (take 0 '(d e f)))))
(cons a (cons b (cons c '())))
(cons a (cons b (c)))
(cons a (b c))
---> (a b c)

(take 4 '(a b))
(cons a (take 3 '(b)))
(cons a (cons b (take 2 '())))
(cons a (cons b '()))
(cons a (b))
---> (a b)
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
|#


;; Oppgave 2b
(define (take n items)
  (define (take-iter in out1 out2)
    (if (or (null? out2) (= in 0))
        out1
        (take-iter (- in 1) (append out1 (list (car out2))) (cdr out2))))
  (take-iter n '() items))

#|
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
I denne halerekursjonen, så skal take-iter være det siste kallet. I det siste kallet så setter vi opp på samme måte som vi gjorde ovenfor, men forskjellen her er at vi har en
iterativ prosess, hvor parametrene til take-iter må oppdatere seg for hvert steg som utføres. Minner også om at resultatet vi får fra denne iterative prosessen blir reversert.
Derfor må vi gjøre et lite triks på out1-parameteren slik at vi får de samme resultatene fra forrige oppgave. Vi bruker da append, hvor de første elementene appender etter out1 slik
at de kommer etter hverandre. Ta eksemplene (take 3 '(a b c d e f)) og (take 4 '(a b)) igjen. Prosessene ser da slik ut:
(take 3 '(a b c d e f))
(take-iter 3 '() '(a b c d e f))
(take-iter 2 (append '() '(a)) '(b c d e f))
(take-iter 1 (append '(a) '(b)) '(c d e f))
(take-iter 0 (append '(a b) '(c)) '(d e f))
---> (a b c)

(take 4 '(a b))
(take-iter 4 '() '(a b))
(take-iter 3 (append '() '(a)) '(b))
(take-iter 2 (append '(a) '(b)) '())
---> (a b)

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
|#

;; Oppgave 2c
(define (take-while pred items)
  (if (or (null? items) (equal? (pred (car items)) #f))
      '()
      (cons (car items)
            (take-while pred (cdr items)))))

#|
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
Vi ønsker å ha en liste med de første elementene som oppfyller predikatet. Her har vi en rekursiv prosess, hvor vi kommer til å ha en lang kjede med cons av det første elemenetet i
listen items, det første elementet til den korresponredende listen (cdr items) og kjeden fortsetter da inntil det første elementet til en annen korresponderende liste (cdr items)
ikke oppfyller predikatet. Ta eksemplet (take-while even? '(2 34 42 75 88 103 250)). Prosessen ser da slik ut:
(take-while even? '(2 34 42 75 88 103 250))
(cons 2 (take-while even? '(34 42 75 88 103 250)))
(cons 2 (cons 34 (take-while even? '(42 75 88 103 250))))
(cons 2 (cons 34 (cons 42 (take-while even? '(75 88 103 250)))))
(cons 2 (cons 34 (cons 42 '())))
(cons 2 (cons 34 (42)))
(cons 2 (34 42))
---> (2 34 42)

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
|#

;; Oppgave 2d
(define (map2 proc item1 item2)
  (if (or (null? item1) (null? item2))
      '()
      (cons (proc (car item1) (car item2))
            (map2 proc (cdr item1) (cdr item2)))))

#|
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
Scheme har en mer generell innebygd versjon av map:
(define (map proc items)
  (if (null? items)
      '()
      (cons (proc (car items))
            (map proc (cdr items)))))
Alt vi trenger å gjøre, er å sette en ekstra parameter (bokstavelig talt), som vi kaller for item2, og følger samme struktur som map. Vi ser da at vi må sjekke om item2 er '(), har
en prosedyre av de første elementene fra begge listene, med en rekursiv prosesss. Med andre ord, så skal item2 oppføre seg på samme måte som item1. Prosessen ser da slik ut:
(map2 + '(1 2 3 4) '(3 4 5))
(cons (+ 1 3) (map2 + '(2 3 4) '(4 5)))
(cons (+ 1 3) (cons (+ 2 4) (map2 + '(3 4) '(5))))
(cons (+ 1 3) (cons (+ 2 4) (cons (+ 3 5) (map2 + '(4) '()))))
(cons (+ 1 3) (cons (+ 2 4) (cons (+ 3 5) '())))
(cons 4 (cons 6 (cons 8 '())))
(cons 4 (cons 6 (8)))
(cons 4 (6 8))
---> (4 6 8)
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

Oppgave 2e
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
Hvis vi ser på map2 som vi har konstruert, så har vi en generell prosedyre proc med to argumenter, som er de to første elementene fra listene. Denne gangen, med en anonym prosedyre,
skal vi regne på gjennomsnittet mellom disse to tallene. lambda-uttrykket vårt ser da slik ut
(lambda (x y)
  (/ (+ x y) 2))

Det lambda-uttrykket gjør er å ta de første elementene fra listene, adderer dem sammen og dividerer summen på 2. Dermed får vi at

(map2 (lambda (x y) (/ (+ x y) 2)) '(1 2 3 4) '(3 4 5))
---> (2 3 4)
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
|#