#lang racket/base

(require ffi/unsafe
         ffi/unsafe/define
         racket/format)

(define-ffi-definer define-snappy
  (ffi-lib "libsnappy" '("1" #f)))

(provide snappy_compress snappy_uncompress
         snappy_max_compressed_length snappy_uncompressed_length
         snappy_validate_compressed_buffer
         compress uncompress valid-compression?)

;; snappy_status
(define _snappy_status
  (_enum '(ok invalid too-small)))

;; compress : Bytes -> Bytes
(define (compress input)
  (define-values (compressed len status) (snappy_compress input))
  (check-status "compress" status)
  (subbytes compressed 0 len))

;; uncompress : Bytes -> Bytes
(define (uncompress input)
  (define-values (uncompressed len status) (snappy_uncompress input))
  (check-status "uncompress" status)
  (subbytes uncompressed 0 len))

;; valid-compression? : Bytes -> Boolean
(define (valid-compression? compressed)
  (eq? 'ok (snappy_validate_compressed_buffer compressed)))

;; check-status : (U 'ok 'invalid 'too-small) -> void?
(define (check-status op status)
  (case status
    [(invalid) (error (~a op ": invalid input"))]
    [(too-small) (error (~a op ": input buffer too small"))]))

;; snappy_status snappy_compress(const char* input,
;;                               size_t input_length,
;;                               char* compressed,
;;                               size_t* compressed_length);
(define-snappy snappy_compress
  (_fun (input : _bytes)
        (input-length : _long = (bytes-length input))
        (compressed : (_bytes o (snappy_max_compressed_length
                                 input-length)))
        (compressed_length : (_ptr o _long))
        -> (status : _snappy_status)
        -> (values compressed compressed_length status)))

;; snappy_status snappy_uncompress(const char* compressed,
;;                                 size_t compressed_length,
;;                                 char* uncompressed,
;;                                 size_t* uncompressed_length);
(define-snappy snappy_uncompress
  (_fun (input : _bytes)
        (_long = (bytes-length input))
        (uncompressed : (_bytes o (uncompressed-length input)))
        (uncompressed_length : (_ptr o _long))
        -> (status : _snappy_status)
        -> (values uncompressed uncompressed_length status)))

;; uncompressed-length : bytes -> int
;; utility function for above binding
(define (uncompressed-length bytes)
  (define-values (len stat)
    (snappy_uncompressed_length bytes))
  (when (eq? stat 'invalid)
    (error "compressed buffer failed to parse"))
  len)

;;size_t snappy_max_compressed_length(size_t source_length);
(define-snappy snappy_max_compressed_length
  (_fun _long -> _long))

;; snappy_status snappy_uncompressed_length(const char* compressed,
;;                                          size_t compressed_length,
;;                                          size_t* result);
(define-snappy snappy_uncompressed_length
  (_fun (input : _bytes)
        (_long = (bytes-length input))
        (length : (_ptr o _long))
        -> (status : _snappy_status)
        -> (values length status)))


;; snappy_status snappy_validate_compressed_buffer
;;      (const char* compressed,
;;       size_t compressed_length);
(define-snappy snappy_validate_compressed_buffer
  (_fun (input : _bytes)
        (_long = (bytes-length input))
        -> (status : _snappy_status)))
