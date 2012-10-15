#lang at-exp racket/base
;; For legal info, see file "info.rkt".

(require (planet neil/mcfly)
         "snappy.rkt")

(provide (all-from-out "snappy.rkt"))

@doc{@section{Introduction}

     @para{This is an FFI binding for the Snappy library
           from Google. Snappy provides very fast compression
           and decompression, though with large compressed sizes.}}

@doc{
  @defproc[(compress [input bytes?]) bytes?]{
    Compresses the input bytestring and returns the
    resulting bytestring.
  }

  @defproc[(uncompress [input bytes?]) bytes?]{
    Uncompresses the input bytestring and returns the
    resulting bytestring.
  }

  @defproc[(valid-compression? [input bytes?]) boolean?]{
    Returns @racket[#t] if @racket[input] is a compressed
    bytestring that can be uncompressed with Snappy.
    Otherwise returns @racket[#f].
  }
}

(doc history
     (#:planet 1:0 #:date "2012-10-14"
               "Initial release."))
