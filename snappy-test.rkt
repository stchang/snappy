#lang racket

(require rackunit
         "snappy.rkt")

(define bstr #"11111111112222222222")
(define-values (compressed len-1 status-1)
  (snappy_compress bstr))

(define new-compressed (subbytes compressed 0 len-1))

(define-values (uncompressed len-2 status-2)
  (snappy_uncompress new-compressed))

(check-equal?
 (subbytes uncompressed 0 len-2)
 bstr)

(check-equal?
 (uncompress (compress bstr))
 bstr)

(check-true (valid-compression? (compress bstr)))

;; random testing
(define (random-byte) (random 10))

(define (random-bstr)
  (list->bytes (for/list ([_ 50000]) (random-byte))))

(for ([n 100])
  (define input (random-bstr))
  (check-true (valid-compression? (compress input)))
  (check-equal?
   input
   (uncompress (compress input))))
