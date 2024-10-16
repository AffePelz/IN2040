(load "evaluator.scm")

(set! the-global-environment (setup-environment))
(mc-eval '(+ 1 2) the-global-environment)

;; Oppgave 1
#|
(define (foo cond else)
  (cond ((= cond 2) 0)
        (else (else cond))))
(define cond 3)
(define (else x) (/ x 2))
(define (square x) (* x x))
(cond ((= cond 2) 0)
      (else (else 4)))


(foo 2 square) --> 0
(foo 4 square) --> 16
(cond ((= cond 2) 0)
      (else (else 4))) --> 2

Alle uttrykk som evalueres er opprinnelig lister med en gitt tag.
Evaluatoren sjekker første element i listen som en streng, og så henter
den ut verdier fra listen avhengig av strengen. 




|#

(define (install-primitive! name proc)
  (define-variable! name (list 'primitive proc) the-global-environment))

