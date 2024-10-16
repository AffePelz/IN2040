;; OBLIG 2B

;; Oppgave 1
;; (a)
(define make-counter
  (lambda ()
    (let ((count 0))
       (lambda ()
         (set! count (+ count 1))
         count))))

#|
(define count 42)
(define c1 (make-counter))
(define c2 (make-counter))
(c1)
(c1)
(c1)
count
(c2)
|#


;; (b)
#|
+-------------------------------------------------------------+
| make-counter:                                               |
|   c2-------------------------------------                   |
|   c1                                    |                   |
|    |                                    |                   |
|    |                                    |                   |
|    |                                    |                   |
|    |                                    |                   |
|    |                                    |                   |
|    |                                    |                   |
+----|------------------------------------|-------------------+
     |              ^                     |            ^
     |              |                     |            |
     |         +---------+                |       +---------+
     |         |count = 3|                |       |count = 0|
     |         +---------+                V       +---------+
   +---++---+       |                +---++---+       |
   ( * )( * )--------                ( * )( * )--------
   +---++---+                        +---++---+
     |                                 |
     |   |------------------------------   
     V   V
     Parameter:
     Body: (lambda ()
             (set! count (+ count 1))
             count)
|#


;; Oppgave 2
;; (a)
(define (make-stack lst)
  (let ((stack lst))
    (lambda (msg . args)
      (cond ((eq? msg 'pop!)
             (if (null? stack)
                 '()
                 (set! stack (cdr stack))))
            ((eq? msg 'push!)
             (set! stack (append (reverse args) stack)))
            ((eq? msg 'stack) stack)))))

#|
(define s1 (make-stack (list 'foo 'bar)))
(define s2 (make-stack '()))
(s1 'pop!)
(s1 'stack)
(s2 'push! 1 2 3 4)
(s2 'stack)
(s1 'push! 'bah)
(s1 'push! 'zap 'zip 'baz)
(s1 'stack)
|#

;; (b)
(define (push! stk . args)
  (define (push-element items)
    (if (not (null? items))
        (begin (stk 'push! (car items))
               (push-element (cdr items)))))
  (push-element args))

(define (stack stk)
  (stk 'stack))

(define (pop! stk . args)
  (stk 'pop! args))

#|
(pop! s1)
(stack s1)
(push! s1 'foo 'faa)
(stack s1)
|#

;; Oppgave 3
;; (a)

#|

Før set-cdr!
         +---+---+      +---+---+     +---+---+     +---+---+     +---+---+
bar -->  | x | x-|----->| x | x-|---->| x | x-|---->| x | x-|---->| x | / |
         +-|-+---+      +-|-+---+     +-|-+---+     +-|-+---+     +-|-+---+
           |              |             |             |             |
           V              V             V             V             V
           a              b             c             d             e



Etter set-cdr!
                          |-------------------------------|
                          V                               |
         +---+---+      +---+---+     +---+---+     +---+-|-+
bar -->  | x | x-|----->| x | x-|---->| x | x-|---->| x | x |
         +-|-+---+      +-|-+---+     +-|-+---+     +-|-+---+
           |              |             |             |      
           V              V             V             V      
           a              b             c             d      

list-ref går til fra element til neste element i lista
til den kommer til den gitte indeksen

(list-ref bar 0) -> a (er første element)
(list-ref bar 3) -> d (er fjerde element)
(list-ref bar 4) -> b (vi går til neste peker fra d, som peker på b)
(list-ref bar 5) -> c (vi går til neste peker fra b, som peker på c)


(define bar (list 'a 'b 'c 'd 'e))
(set-cdr! (cdddr bar) (cdr bar))
(list-ref bar 0)
(list-ref bar 3)
(list-ref bar 4)
(list-ref bar 5)
|#


;; (b)
#|
Før set-car!

         +---+---+      +---+---+     +---+---+
bah -->  | x | x-|----->| x | x-|---->| x | / |
         +-|-+---+      +-|-+---+     +-|-+---+
           |              |             |   
           V              V             V   
         bring            a           towel



Etter første set-car!

           |--------------| 
           |              V
         +-|-+---+      +---+---+     +---+---+
bah -->  | x | x-|----->| x | x-|---->| x | / |
         +---+---+      +-|-+---+     +-|-+---+
                          |             |   
                          V             V   
                          a           towel


(define bah (list 'bring 'a 'towel))
(set-car! bah (cdr bah))
(set-car! (car bah) 42)


Vi får ((42 towel) 42 towel) fordi (car bah) peker
på (cdr bah) når vi har gjort det første set-car! kallet.
Dermed vil (car bah) og (cdr bah) peke på samme liste, og når
vi endrer a til 42 så endrer vi car av lista, som både (car bah)
og (cdr bah) peker på.
|#

;; (c)
(define (cycle? lst)
  (define (cycle-check one two)
        (cond ((null? (cdr two)) #f)
              ((null? (cddr two)) #f)
              ((eq? one two) #t)
              (else (cycle-check (cdr one) (cddr two)))))
  (if (and (null? lst) (null? (cdr lst)))
      #f
      (cycle-check lst (cdr lst))))


;; (d)
#|
Sirkulære lister er egentlig ikke lister siden
de ikke er bygd opp av cons-celler hvor det siste
elementet er den tomme lista. I sirkulære lister
peker det siste elementet heller på en tidligere
celle.
|#
