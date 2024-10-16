(load "prekode3a.scm")
;; Thuan Quang Tran (thuanqt), Stian Skjegstad Østgaard (stiasos), Embrik Hafskjold Thoresen (embrikht)

;; Oppgave 1
;; (a) og (b)

(define original-proc (lambda () '()))

(define (mem msg proc)
  (let ((table (make-table)))
    (cond ((eq? msg 'memoize)
           (lambda args
              (let ((stored (lookup args table)))
                (or stored
                    (let ((res (apply proc args)))
                      (insert! args res table)
                      (set! original-proc proc)
                      res)))))
          ((eq? msg 'unmemoize) original-proc)
          (else (display "error")))))


;; (c)
#|
Ved å definere mem-fib til å være (mem 'memoize fib) så vil
fib i prekoden kalle på seg selv rekursivt som normalt og lagrer
sluttverdien i tabellen. Dette er ikke det vi ønsker.
Når vi skriver (set! fib (mem 'memoize fib)) så vil fib i prekoden
kalle rekursivt på den høyreordens prosedyren fib som vi definerte
i (a) og (b). Da lagrer vi verdiene av fib (fra prekoden) i
tabellen vår for hvert rekursivt kall.
|#

;; Oppgave 2
;; (a)
(define (list-to-stream lst)
  (if (stream-null? lst)
      the-empty-stream
      (cons-stream (car lst) (list-to-stream (cdr lst)))))

(define (stream-to-list stream . args)
  (if (or (= (car args) 0) (stream-null? stream))
      '()
      (cons (stream-car stream)
            (stream-to-list (stream-cdr stream)
                            (if (not (null? args))
                            (- (car args) 1))))))

;; (b)
(define (stream-take n stream)
  (if (= n 0)
      the-empty-stream
      (cons-stream (stream-car stream)
                   (stream-take (- n 1) (stream-cdr stream)))))

;; (c)
#|
Petter Smart sitt forslag funker dersom man vet at man har en
endelig strøm. Dersom strømmen er uendelig vil remove-
duplicates-prosedyren kjøre rekursivt i det uendelige.
Dette er fordi prosedyren cons'er (car lst) med (cdr lst)
og tester om et gitt symbol forekommer i cdr av strømmen.
Dette må den sjekke uendelig antall ganger siden strømmen
er uendelig.
|#

;; (d)
(define (remove-duplicates stream)
  (if (stream-null? stream)
      the-empty-stream
      (cons-stream (stream-car stream)
                   (remove-duplicates
                    (stream-filter (lambda (x) (not (eq? x (stream-car stream))))
                                   (stream-cdr stream))))))

             