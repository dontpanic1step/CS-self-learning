(define (caar x) (car (car x)))
(define (cadr x) (car (cdr x)))
(define (cdar x) (cdr (car x)))
(define (cddr x) (cdr (cdr x)))

; Some utility functions that you may find useful to implement

(define (zip pairs)
  (define (zip-helper-1 p)
      (if (null? p) nil (cons (caar p) (zip-helper-1 (cdr p)))))
  (define (zip-helper-2 p)
      (if (null? p) nil (cons (car (cdar p)) (zip-helper-2 (cdr p)))))
  (list (zip-helper-1 pairs) (zip-helper-2 pairs))
)


;; Problem 15
;; Returns a list of two-element lists
(define (enumerate s)
  ; BEGIN PROBLEM 15
  (define (make-pair i lst)
      (if (null? lst) nil 
          (cons (list i (car lst)) (make-pair (+ i 1) (cdr lst)))
          ))
  (make-pair 0 s)
  )
  ; END PROBLEM 15

;; Problem 16

;; Merge two lists LIST1 and LIST2 according to COMP and return
;; the merged lists.
(define (merge comp list1 list2)
  ; BEGIN PROBLEM 16
  (cond ((null? list1) list2)
        ((null? list2) list1)
        ((comp (car list1) (car list2)) (cons (car list1) (merge comp (cdr list1) list2)))
        (else (cons (car list2) (merge comp list1 (cdr list2))))
  )
  )
  ; END PROBLEM 16


(merge < '(1 5 7 9) '(4 8 10))
; expect (1 4 5 7 8 9 10)
(merge > '(9 7 5 1) '(10 8 4 3))
; expect (10 9 8 7 5 4 3 1)

;; Problem 17

(define (nondecreaselist s)
    ; BEGIN PROBLEM 17
    (define (sub last lst)
        (cond ((null? lst) nil)
              ((null? last) (cons (car lst) (sub (car lst) (cdr lst))))
              ((> last (car lst)) nil)
              (else (cons (car lst) (sub (car lst) (cdr lst))))
                    ))
    (define (find-head lst last)
        (cond ((null? lst) nil)
              ((null? last) (find-head (cdr lst) (car lst)))
              ((< (car lst) last) lst)
              (else (find-head (cdr lst) (car lst)))))
    (if (null? s) nil 
    (cons (sub nil s) (nondecreaselist (find-head s nil))))
    )
    ; END PROBLEM 17

;; Problem EC
;; Returns a function that checks if an expression is the special form FORM
(define (check-special form)
  (lambda (expr) (equal? form (car expr))))

(define lambda? (check-special 'lambda))
(define define? (check-special 'define))
(define quoted? (check-special 'quote))
(define let?    (check-special 'let))

;; Converts all let special forms in EXPR into equivalent forms using lambda
(define (let-to-lambda expr)
  (cond ((atom? expr)
         ; BEGIN PROBLEM EC
         expr
         ; END PROBLEM EC
         )
        ((quoted? expr)
         ; BEGIN PROBLEM EC
         expr
         ; END PROBLEM EC
         )
        ((or (lambda? expr)
             (define? expr))
         (let ((form   (car expr))
               (params (cadr expr))
               (body   (cddr expr)))
           ; BEGIN PROBLEM EC
           (cons form (cons params (map let-to-lambda body)))
           ; END PROBLEM EC
           ))
        ((let? expr)
         (let ((values (cadr expr))
               (body   (cddr expr)))
           ; BEGIN PROBLEM EC
           ;(cons (list 'lambda (car (zip values)) (car body)) (cadr (zip values)))
           ;(append `(lambda ,(car (zip values)) ,(car body)) (cadr (zip values))))
            ;(cons
            ;(cons 'lambda (cons (car (zip (let-to-lambda values))) (let-to-lambda body))) 
            ;(cadr (zip (let-to-lambda values)))
            ;)
            (define tmp (zip values))
           (append (cons (cons 'lambda (cons (car tmp) (map let-to-lambda body))) nil) (map let-to-lambda (cadr tmp)))
           ; END PROBLEM EC
           ))
        (else
         ; BEGIN PROBLEM EC
         (cons (car expr) (map let-to-lambda (cdr expr)))
         ; END PROBLEM EC
         )))

