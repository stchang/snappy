#lang scribble/manual

@(require (for-label racket/base
                     racket/contract
                     snappy))

@title{Snappy: FFI bindings for fast compression}

@section{Introduction}

This is an FFI binding for the Snappy library from Google. Snappy provides very
fast compression and decompression, though with large compressed sizes.

@defmodule[snappy]

@defproc[(compress [input bytes?]) bytes?]{
  Compresses the input bytestring and returns the
  resulting bytestring.
}

@defproc[(uncompress [input (and/c bytes? valid-compression?)]) bytes?]{
  Uncompresses the input bytestring and returns the
  resulting bytestring.
}

@defproc[(valid-compression? [input bytes?]) boolean?]{
  Returns @racket[#t] if @racket[input] is a compressed
  bytestring that can be uncompressed with Snappy.
  Otherwise returns @racket[#f].
}

