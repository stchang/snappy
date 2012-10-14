#lang racket/base

(require ffi/unsafe
         ffi/unsafe/define)

(define-ffi-definer define-snappy (ffi-lib "libsnappy"))

(provide snappy_compress snappy_uncompress
         snappy_max_compressed_length snappy_uncompressed_length
         snappy_validate_compressed_buffer
         compress uncompress valid-compression?)

;; compress : Bytes -> Bytes
(define (compress input)
  (define-values (compressed len status) (snappy_compress input))
  (unless (zero? status) (error "could not compress"))
  (subbytes compressed 0 len))

;; uncompress : Bytes -> Bytes
(define (uncompress input)
  (define-values (uncompressed len status) (snappy_uncompress input))
  (unless (zero? status) (error "could not uncompress"))
  (subbytes uncompressed 0 len))

;; valid-compression? : Bytes -> Boolean
(define (valid-compression? compressed)
  (zero? (snappy_validate_compressed_buffer compressed)))
  
  

;; snappy_status snappy_compress(const char* input,
;;                               size_t input_length,
;;                               char* compressed,
;;                               size_t* compressed_length);
(define-snappy snappy_compress
  (_fun (input : _bytes)
        (_uint = (bytes-length input))
        (compressed : (_bytes o (snappy_max_compressed_length
                                 (bytes-length input))))
        (compressed_length : (_ptr o _uint))
        -> (status : _uint)
        -> (values compressed compressed_length status)))

;; snappy_status snappy_uncompress(const char* compressed,
;;                                 size_t compressed_length,
;;                                 char* uncompressed,
;;                                 size_t* uncompressed_length);
(define-snappy snappy_uncompress
  (_fun (input : _bytes)
        (_uint = (bytes-length input))
        (uncompressed : (_bytes o 100))
        (uncompressed_length : (_ptr o _uint))
        -> (status : _uint)
        -> (values uncompressed uncompressed_length status)))

;;size_t snappy_max_compressed_length(size_t source_length);
(define-snappy snappy_max_compressed_length
  (_fun _uint -> _uint))

;; snappy_status snappy_uncompressed_length(const char* compressed,
;;                                          size_t compressed_length,
;;                                          size_t* result);
(define-snappy snappy_uncompressed_length
  (_fun (input : _bytes)
        (_uint = (bytes-length input))
        (length : (_ptr o _uint))
        -> (status : _uint)
        -> (values length status)))


;; snappy_status snappy_validate_compressed_buffer
;;      (const char* compressed,
;;       size_t compressed_length);
(define-snappy snappy_validate_compressed_buffer
  (_fun (input : _bytes)
        (_uint = (bytes-length input))
        -> (status : _uint)))