(define (not x) (if x #f #t))
(define (null? x) (if (eqv? x '()) #t #f))

(define (between? a b n)
        (&& (<= a n)
            (>= b n)))

(define (list . objs) objs)

(define (id obj) obj)

(define (flip func) (lambda (arg1 arg2) (func arg2 arg1)))

(define (curry func arg1) (lambda (arg) (apply func (cons arg1 (list arg)))))
(define (compose f g) (lambda (arg) (f (apply g arg))))

(define zero? (curry = 0))
(define positive? (curry < 0))
(define negative? (curry > 0))
(define (odd? num) (= (mod num 2) 1))
(define (even? num) (= (mod num 2) 0))

(define (foldr func end lst)
  (if (null? lst)
      end
      (func (car lst) (foldr func end (cdr lst)))))
(define (foldl func accum lst)
  (if (null? lst)
      accum
      (foldl func (func accum (car lst)) (cdr lst))))

(define fold foldl)
(define reduce fold)

(define (unfold func init pred)
  (if (pred init)
      (cons init '())
      (cons init (unfold func (func init) pred))))

(define (sum . lst) (fold + 0 lst))
(define (product . lst) (fold * 1 lst))
(define (and . lst) (fold and #t lst))
(define (or . lst) (fold or #f lst))

(define (max first . rest) (fold (lambda (old new) (if (> old new) old new)) first rest))
(define (min first . rest) (fold (lambda (old new) (if (< old new) old new)) first rest))

(define (length lst) (fold (lambda (x y) (+ x 1)) 0 lst))
(define (string-length s) (length (char-list s)))

(define (in-array x lst)
    (if (null? lst)
        #f
        (|| (eqv? (car lst) x) (in-array x (cdr lst)))))

(define (append a b) (foldr cons b a))
; (print (append '(4 5) '(5 6)))

(define (concat lst) (foldr (lambda (x y) (append x y)) '() lst))
; (print (concat '( (4 5) (5 6) (6 7) )))

(define (string-charat n s)
    (list-index n (char-list s)))
(define (string-concat lst) (foldr (lambda (x y) (string-append x y)) "" lst))

(define (reverse lst) (fold (flip cons) '() lst))

(define (mem-helper pred op) (lambda (acc next) (if (and (not acc) (pred (op next))) next acc)))
(define (memq obj lst) (fold (mem-helper (curry eq? obj) id) #f lst))
(define (memv obj lst) (fold (mem-helper (curry eq? obj) id) #f lst))
(define (member obj lst) (fold (mem-helper (curry equal? obj) id) #f lst))
(define (assq obj alist) (fold (mem-helper (curry eq? obj) car) #f alist))
(define (assv obj alist) (fold (mem-helper (curry eq? obj) car) #f alist))
(define (assoc obj alist) (fold (mem-helper (curry equal? obj) car) #f alist))

(define (map func lst) (foldr (lambda (x y) (cons (func x) y)) '() lst))
(define (filter pred lst) (foldr (lambda (x y) (if (pred x) (cons x y) y)) '() lst))
