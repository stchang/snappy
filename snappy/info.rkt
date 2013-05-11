#lang setup/infotab


(define mcfly-planet       'stchang/snappy:1:0)

(define name               "snappy")

(define mcfly-subtitle     "fast compression/decompression")

(define blurb              (list name ": " mcfly-subtitle))

(define homepage           "https://github.com/stchang/snappy")

(define mcfly-author       "Stephen Chang and Asumu Takikawa")

(define repositories       '("4.x"))

(define categories         '(misc))

(define can-be-loaded-with 'all)

(define scribblings        '(("doc.scrbl" () (library))))

(define primary-file       "main.rkt")

(define mcfly-start        "main.rkt")

(define mcfly-files        '(defaults "snappy-test.rkt" "snappy.rkt"))

(define mcfly-license      "New BSD License")

(define mcfly-legal        "Copyright 2012 Stephen Chang & Asumu Takikawa.")
