#lang racket

(require "snappy.rkt")

(define-values (compressed len status)
  (snappy_compress #"11111111112222222222"))

;(define new-compressed (subbytes compressed 0 len))

;(snappy_uncompress new-compressed)

;(snappy_max_compressed_length 10)

;(snappy_uncompressed_length new-compressed)

(uncompress (compress #"11111111112222222222"))
;(snappy_validate_compressed_buffer new-compressed)