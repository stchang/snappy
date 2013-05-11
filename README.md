Racket FFI bindings for snappy
==============================

Racket FFI bindings for the [snappy](http://code.google.com/p/snappy/)
compression library.

To install on Racket v5.3.2 or newer:
  * `raco pkg install snappy`

On older versions of Racket:
  * `git clone https://github.com/stchang/snappy`
  * `raco link snappy/snappy`

---

```racket
 (require snappy)
```

```racket
(compress input) -> bytes?
  input : bytes?
```

Compresses the input bytestring and returns the resulting bytestring.

```racket
(uncompress input) -> bytes?
  input : (and/c bytes? valid-compression?)
```

Uncompresses the input bytestring and returns the resulting bytestring.

```racket
(valid-compression? input) -> boolean?
  input : bytes?
```

Returns `#t` if `input` is a compressed bytestring that can be
uncompressed with Snappy. Otherwise returns `#f`.

---

Copyright (c) 2013 Stephen Chang, Asumu Takikawa

Licensed under the BSD license. See COPYING.

