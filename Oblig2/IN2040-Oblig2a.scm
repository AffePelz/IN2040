;;stiasos, thuanqt og embrikht
(load "huffman.scm")

;; Oppgave 1
;; (a)
(define (p-cons x y)
  (lambda (proc) (proc x y)))

(define (p-car proc)
  (proc (lambda (x y) x)))

(define (p-cdr proc)
  (proc (lambda (x y) y)))

;; (p-car (p-cons "foo" "bar")) --> Kalleksempel
;; (p-car (proc "foo" "bar")) --> Hva prosedyren gir 
;; (p-car #<procedure:...2040-Oblig2a.scm:6:2>) --> Resultatet av prosedyren
;; (proc "foo" "bar") --> Bestående av x og y hvor vi returnerer x
;; "foo" --> Resultatet av prosedyren

;; (b)
;; lambda-versjonen

(define foo 42)

((lambda (foo x)
 (if (= x foo) 'same 'different))
 5 foo)

((lambda (bar baz)
   ((lambda (bar foo)
      (list foo bar))
    (list bar baz) baz))
 foo 'towel)

;; (c)
(define (infix-eval exp)
  ((cadr exp) (car exp) (caddr exp)))

;; (d)
#|
(define bah '(84 / 2))
(infix-eval bah) ;; Feilmelding, fordi / blir ikke tolket som en prosedyre, men en quote
|#

;; Oppgave 2
;; (a)
;; Er halerekursiv fordi det siste kallet er (decode-1)

(define (decode bits tree)
  (define (decode-1 bits current-branch message)
    (if (null? bits)
        message
        (let ((next-branch
               (choose-branch (car bits) current-branch)))
          (if (leaf? next-branch)
              (decode-1 (cdr bits) tree (append message (list (symbol-leaf next-branch))))
              (decode-1 (cdr bits) next-branch message)))))
  (decode-1 bits tree '()))

;; (b)
;; (decode sample-code sample-tree) --> (samurais fight ninjas by night)

;; (c)
;; in-list sjekker om noe er et element av en liste,
;; returnerer enten #t eller #f
(define (in-list? list element)
  (define (in-list-iter in)
    (cond ((null? in) #f)
          ((equal? element (car in)) #t)
          (else (in-list-iter (cdr in)))))        
  (in-list-iter list))


(define (encode message tree)
  (define (encode-1 message current-branch bits)
    (if (null? message)
        bits
        (cond ((leaf? current-branch) (encode-1 (cdr message) tree bits))
              ((in-list? (symbols (right-branch current-branch)) (car message))
               (encode-1 message (right-branch current-branch) (append bits (list 1))))
              ((in-list? (symbols (left-branch current-branch)) (car message))
               (encode-1 message (left-branch current-branch) (append bits (list 0)))))))
  (encode-1 message tree '()))

;; (d)

(define (grow-huffman-tree list)
  (define (help list)
    (if (null? (cddr list))
       (make-code-tree (car list) (cadr list))
       (help (adjoin-set (make-code-tree (car list) (cadr list))
                                      (cddr list)))))
  (help (make-leaf-set list)))
  
(define freqs '((a 2) (b 5) (c 1) (d 3) (e 1) (f 3)))
(define codebook (grow-huffman-tree freqs))

;; (e)
(define freqs2 '((samurais 57) (ninjas 20) (fight 45) (night 12) (hide 3) (in 2) (ambush 2) (defeat 1) (the 5) (sword 4) (by 12) (assassin 1) (river 2) (forest 1) (wait 1) (poison 1)))
(define codebook1 (grow-huffman-tree freqs2))

#|
(encode '(ninjas fight) codebook1)
(encode '(ninjas fight ninjas) codebook1)
(encode '(ninjas fight samurais) codebook1)
(encode '(samurais fight) codebook1)
(encode '(samurais fight ninjas) codebook1)
(encode '(ninjas fight by night) codebook1)
|#

#|
Ved å summere lengden til alle kodeordene vil vi bruke 43 bits
på å kode meldingen.

Ved å summere lengden til alle kodeordene og dele på antall
kodeord får vi at den gjennomsnittlige lengden på hvert kodeord
som brukes er omtrent 2.5 bits.

Dersom vi ville ha kodet meldingen med fast lengde over det samme alfabetet
ville vi ha trengt minst 4 bits. Dette er fordi alle kodeordene må ha
lik lengde, og vi har 16 kodeord. Vi får 2^4 ulike bits som representerer
hvert sitt kodeord. Dette gir oss at 4 vil være det minste antall bits
vi trenger.
|#

;; (f)
(define (huffman-leaves tree)
  (define (iter res tree)
    (if (leaf? tree)
        (cons (cdr tree) res)
        (append (iter res (left-branch tree))
                (iter res (right-branch tree)))))
  (iter '() tree))
