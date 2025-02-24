#lang racket/base

(require net/url
         racket/contract
         racket/format
         racket/string)

(provide
 urlish/c
 ->url
 url-scheme*
 url-port*
 url-path&query)

(define urlish/c
  (or/c bytes? string? url?))

(define (->url urlish)
  (cond
    [(url? urlish) urlish]
    [(bytes? urlish) (string->url* (bytes->string/utf-8 urlish))]
    [else (string->url* urlish)]))

(define (string->url* s)
  (cond
    [(regexp-match? #px"^[^:]+://" s)
     (define u (string->url s))
     (struct-copy url u
                  [scheme (string-trim #:repeat? #t (url-scheme u))]
                  [host   (string-trim #:repeat? #t (url-host   u))])]

    [(string-prefix? s "://")
     (string->url* (~a "http" s))]

    [else
     (string->url* (~a "http://" s))]))

(module+ internal
  (provide string->url*))

(define (url-scheme* u)
  (or (url-scheme u)
      (case (url-port u)
        [(443) "https"]
        [else  "http"])))

(define (url-port* u)
  (or (url-port u)
      (case (url-scheme u)
        [("https") 443]
        [else      80])))

(define (url-path&query u [params null])
  (define path (url-path u))
  (define all-params (append (url-query u) params))
  (define abs-path
    (if (null? path)
        (list (path/param "" null))
        path))
  (url->string (url #f #f #f #f #t abs-path all-params #f)))
