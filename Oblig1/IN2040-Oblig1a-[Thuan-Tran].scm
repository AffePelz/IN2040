;; IN2040-oblig1a-[Thuan-Tran].scm
#|
Oppgave 1a
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
(* (+ 4 2) 5)

Vi bruker da evalueringsreglene for å se hva slags verdi vi får (eller eventuelt hva slags feil vi får). Det første vi må gjøre er å evaluere enkeltuttrykkene, og i dette tilfellet
er det (+ 4 2). Dette uttrykket evalueres da til 6. Dermed har vi (* 6 5), som da evalueres til 30. Dermed vil vi få 30 som verdi. Prosessen ser da slik ut:
(* (+ 4 2) 5)
(* 6 5)
--> 30
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

Oppgave 1b
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
(* (+ 4 2) (5))

Samme som i oppgave 1a, evalueres enkeltuttrykket (+ 4 2) til 6, og da har vi (* 6 (5)). Her oppstår det da en feil. Grunnen til det er fordi (5) er inni i en parantes (i tillegg er
5 det første elementet). Minner om at prosedyrer må alltid være det første elementet inni parantesen og tallet 5 er ikke en prosedyre (og har i tillegg ingen argumenter).  Derfor får
vi feilmeldingen at 5 ikke er en prosedyre.
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

Oppgave 1c
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
(* (4 + 2) 5)

Som i oppgave 1a og 1b, så er vårt enkeltuttrykk (4 + 2), men her oppstår det en feil. Grunnen til det er fordi at det første elementet (som er 4) ikke er en prosedyre og prosedyren
(som er +) er satt opp som et argument. Prosedyren + må alltid stå først, som vi har sett i oppgave 1a og 1b.
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

Oppgave 1d
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
(define bar (/ 44 2))
bar

Ifølge evalueringsregelen, så har vi en variabel som vi må evaluere først, og denne variabelen evalueres til verdien den refererer til, som er da (/ 44 2), og dette enkelt-uttrykket
evalueres da til verdien 22. Prosessen ser da slik ut:
bar
(/ 44 2)
--> 22
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

Oppgave 1e
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
(- bar 11)

Ifølge evalueringsreglene, så har vi en variabel som vi må evaluere først, og den evaluerer da til verdien den refererer til, som er da (/ 44 2) (fra oppgave 1d), som igjen er et
enkelt-uttrykk hvor vi må evaluere først, som evalueres til 22. Da sitter vi igjen med (- 22 11), som da evalueres til 11. Prosessen er da slik ut:
(-bar 11)
(- (/ 44 2) 11)
(- 22 11)
--> 11
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

Oppgave 1f
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
(/ (* bar 3 4 1) bar)

Ifølge evalueringsreglene, så har vi to variabler som vi må evaluere først, og de evalueres da til (/44 2). Deretter blir disse enkelt-uttrykkene evaluert, som da blir til verdien
22. Så må vi evaluere (* 22 3 4 1), som blir da 264. Da sitter vi igjen med enkelt-uttrykket (/ 264 22), som da evalueres til verdien 12. Prosessen ser da slik ut:
(/ (* bar 3 4 1) bar)
(/ (* (/ 44 2) 3 4 1) (/ 44 2))
(/ (* 22 3 4 1) 22)
(/ 264 22)
--> 12
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

Oppgave 2a
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
1) Vi ser at vi har or i
   (or (= 1 2)
       "paff!"
       "piff!"
       (zero? (1 - 1)))
   Her evalueres argumentene en om gangen fra venstre til høyre. Det første uttrykket er ikke sant, siden 1 er ikke lik 2. Dermed går den videre til neste argument, som er "paff!",
   som da er alltid sann. I or så evalueres det første argumentet som er sann, og returnerer da dette argumentet. Derfor returneres "paff!" hvis vi kjører programmet.
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
2) Denne gangen så har vi and i
   (and (= 1 2)
     "paff!"
     "piff!"
     (zero? (1 - 1)))
   Som i or, så evalueres argumentene en om gangen fra venstre til høyre. Forskjellen her er at med en gang ett av argumentene er usann, så evalueres ikke de andre argumentene og
   dermed returneres #f (false).
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
3) I if,
   (if (positive? 42)
       "poff!"
       (i-am-undefined))
   så evalures predikatet (positive? 42) om den er sann eller usann. Her evalueres om tallet 42 er et positivt tall eller ikke. Siden dette er sann, så evalueres det første
   argumentet "poff!", og returnerer da dette.
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
Anta at or, and og if er vanlige prosedyrer. Da betyr det at alle argumentene skulle evalueres. I or, så ser vi bare at første og andre uttrykk blir evaluert og det andre blir
returnert (fordi den er sann), så den evaluerer ikke de to siste som "piff!" og (zero? (1 - 1)). Dersom vi hadde byttet plass på argumentene slik at vi hadde
(or (zero? (1 - 1)
    (= 1 2)
    "paff!"
    "piff!"))
(eller anta at (zero? (1 - 1)) ble også evaluert), så ville vi ha fått en feil pga (1 - 1). Det samme skjer med and. I and så evalueres ikke de andre uttrykkene fordi med en gang den
møter et uttrykk som er usann, så evalueres ikke de andre uttrykkene og returner da #f. Igjen, hvis det siste uttrykket hadde byttet plass med det første uttrykket slik at vi hadde
(and (zero? (1 - 1)
     (= 1 2)
     "paff!"
     "piff!")),
(eller anta at (zero? (1 - 1)) ble også evaluert), så ville vi ha fått en feil pga (1 - 1). I if, så ser vi på forklaringen i 3) at bare én av uttrykkene blir evaluert, avhengig om
predikatet er sann eller usann. Det betyr at det andre uttrykket blir ikke evaluert (hvis vi hadde antatt at i-am-undefined ble også evaluert, så ville vi ha fått feil fordi
i-am-undefined har vi ennå ikke definert). Derfor kan vi konkludere at disse special forms (or, and og if) bryter med evalueringsreglene Scheme bruker for vanlige prosedyrer.
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
|#
;; Oppgave 2b
(define (sign x)
  (if (< x 0)        ;; Hvis (< x 0) er sann, returneres -1
      -1
      (if (> x 0)    ;; Eller hvis (> x 0) er sann, returneres 1. Hvis ikke, returneres 0
          1
          0)))

(define (sign x)
  (cond ((< x 0) -1) ;; Hvis (< x 0) er sann, returneres -1
        ((> x 0) 1)  ;; Hvis (> x 0) er sann, returneres 1
        (else 0)))   ;; Hvis begge ovenfor er usanne, returneres 0

;; Oppgave 2c
(define (sign x)
  (or (and
       (> x 0)
       1)
      (or (and
           (< x 0)
           -1)
          (or (and
               (= x 0)
               0)))))
#|
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
Inni and, hvis begge argumentene er sanne (når vi har gitt x en verdi), returneres det siste argumentet i and. I or, så evaluerer den bare argumentet som er sann og returnerer denne
verdien (som vi har forklart i oppgave 2a).
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
|#

;; Oppgave 3a
(define (add1 x)
  (+ x 1))         ;; Adderer verdien x med 1

(define (sub1 x)
  (- x 1))         ;; Subtraherer verdien x med 1

;; Oppgave 3b
(define (plus x y)
  (if (zero? x) 
      y                             ;; Returnerer verdien y hvis x er null
      (add1 (plus (sub1 x) y))))    ;; Hvis ikke, så kaller prosedyren på seg selv og får en lang kjede

;; Oppgave 3c
#|
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
Vi tar f. eks to tall x = 4 og y = 6. La oss se hva som skjer under prosessen
(plus 4 6)
(add1 (plus (sub1 3) 6))
(add1 (add1 (plus (sub1 2) 6)))
(add1 (add1 (add1 (plus (sub1 1) 6))))
(add1 (add1 (add1 (add1 (plus 0 6)))))
(add1 (add1 (add1 (add1 6))))
(add1 (add1 (add1 7)))
(add1 (add1 8))
(add1 9)
--> 10
Vi kan se at vår hovedprosedyre (plus) ikke blir brukt inntil sub1 x kommer til 0. Når x blir 0, så returneres verdien y, og så må vi addere denne verdien med 1 siden vi får en lang
kjede med add1-prosedyren. På grunn av denne lange kjeden, må vi vente med å evaluere prosedyren plus. Derfor er dette en rekursiv prosess. I forhold til den iterative prosessen, så
fikser vi på variablene x og y med en regel som sier hvordan variablene skal oppdatere seg for hvert steg. Inntil x = 0 evalueres y. Koden nedenfor er da en iterativ prosess.
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
|#
;; Iterativ
(define (plus x y)
  (if (= x 0)
      y
      (plus (sub1 x) (add1 y))))
#|
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
Prosessen ser da slik ut:
(plus 4 6)
(plus (sub1 4) (add1 6))
(plus (sub1 3) (add1 7))
(plus (sub1 2) (add1 8))
(plus (sub1 1) (add1 9))
(plus 0 (add1 9))
--> 10
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
|#

;; Oppgave 3d
(define (power-close-to b n)
  (define (power-iter e)
    (if (> (expt b e) n)
        e
        (power-iter (+ 1 e))))
  (power-iter 1))
#|
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
Det vi har gjort med hjelpe-prosedyren power-iter, er å sette den internt (med andre ord inni power-close-to). Når vi mener å forenkle, så fjerner vi bare de parametrene fra
power-iter som vi ikke nødvendigvis trenger. Her ser vi at vi kan bare fjerne parametrene b og n fra power-iter fordi vi kan fortsatt bruke b- og n-parametrene fra power-close-to,
og dermed har vi at b og n er frie variabler i definisjonen av power-iter.
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
|#

;; Oppgave 3e
(define (fib n)
  (define (fib-iter a b count)
    (if (= count 0)
        b
        (fib-iter (+ a b) a (- count 1))))
  (fib-iter 1 0 n))
#|
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
Som ovenfor vil vi se om parametrene til fib-iter kan fjernes, men dessverre kan vi ikke det. Grunnen til det er fordi at vi her har en iterativ prosedyre som bare gir opphav til en
iterativ prosess. Vi kan se (fra forklaringen i oppgave 3c) at en iterativ prosess er avhengig av å ha parametrene til å oppdatere seg for hvert steg inntil count er lik null og
returnerer b. Derfor kan vi konkludere at vi ikke kan forenkle hjelpe-prosedyren.
---------------------------------------------------------------------------------------------------------------------
|#