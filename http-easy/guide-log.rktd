;; This file was created by make-log-based-eval
((require racket/contract) ((3) 0 () 0 () () (c values c (void))) #"" #"")
((require net/http-easy) ((3) 0 () 0 () () (c values c (void))) #"" #"")
((define res (get "https://example.com"))
 ((3) 0 () 0 () () (c values c (void)))
 #""
 #"")
((response-status-code res) ((3) 0 () 0 () () (q values 200)) #"" #"")
((response-status-message res)
 ((3) 0 () 0 () () (c values c (u . #"OK")))
 #""
 #"")
((response-headers-ref res 'date)
 ((3) 0 () 0 () () (c values c (u . #"Fri, 12 Jun 2020 08:04:14 GMT")))
 #""
 #"")
((subbytes (response-body res) 0 30)
 ((3) 0 () 0 () () (c values c (u . #"<!doctype html>\n<html>\n<head>\n")))
 #""
 #"")
((response-close! res) ((3) 0 () 0 () () (c values c (void))) #"" #"")
((define res (get "https://example.com" #:drain? #f))
 ((3) 0 () 0 () () (c values c (void)))
 #""
 #"")
((input-port? (response-output res)) ((3) 0 () 0 () () (q values #t)) #"" #"")
((read-string 5 (response-output res))
 ((3) 0 () 0 () () (c values c (u . "<!doc")))
 #""
 #"")
((read-string 5 (response-output res))
 ((3) 0 () 0 () () (c values c (u . "type ")))
 #""
 #"")
((response-status-line
  (get "https://httpbin.org/basic-auth/Aladdin/OpenSesame"))
 ((3) 0 () 0 () () (c values c (u . #"HTTP/1.1 401 UNAUTHORIZED")))
 #""
 #"")
((response-json
  (get
   "https://httpbin.org/basic-auth/Aladdin/OpenSesame"
   #:auth
   (auth/basic "Aladdin" "OpenSesame")))
 ((3)
  0
  ()
  0
  ()
  ()
  (c values c (h - () (authenticated . #t) (user u . "Aladdin"))))
 #""
 #"")
((response-json
  (get "https://httpbin.org/bearer" #:auth (auth/bearer "secret-api-key")))
 ((3)
  0
  ()
  0
  ()
  ()
  (c values c (h - () (authenticated . #t) (token u . "secret-api-key"))))
 #""
 #"")
((response-json
  (get
   "https://httpbin.org/bearer"
   #:auth
   (lambda (uri headers params)
     (values
      (hash-set headers 'authorization "Bearer secret-api-key")
      params))))
 ((3)
  0
  ()
  0
  ()
  ()
  (c values c (h - () (authenticated . #t) (token u . "secret-api-key"))))
 #""
 #"")
((define res
   (response-json
    (post "https://httpbin.org/post" #:form '((a . "hello") (b . "there")))))
 ((3) 0 () 0 () () (c values c (void)))
 #""
 #"")
((hash-ref res 'form)
 ((3) 0 () 0 () () (c values c (h - () (b u . "there") (a u . "hello"))))
 #""
 #"")
((define res
   (response-json
    (post
     "https://httpbin.org/anything"
     #:json
     (hasheq 'a "hello" 'b "there"))))
 ((3) 0 () 0 () () (c values c (void)))
 #""
 #"")
((hash-ref res 'json)
 ((3) 0 () 0 () () (c values c (h - () (b u . "there") (a u . "hello"))))
 #""
 #"")
((define res
   (response-json (post "https://httpbin.org/anything" #:data #"hello")))
 ((3) 0 () 0 () () (c values c (void)))
 #""
 #"")
((hash-ref res 'data) ((3) 0 () 0 () () (c values c (u . "hello"))) #"" #"")
((require net/cookies net/url racket/class)
 ((3) 0 () 0 () () (c values c (void)))
 #""
 #"")
((define jar (new list-cookie-jar%))
 ((3) 0 () 0 () () (c values c (void)))
 #""
 #"")
((define session-with-cookies (make-session #:cookie-jar jar))
 ((3) 0 () 0 () () (c values c (void)))
 #""
 #"")
((parameterize
  ((current-session session-with-cookies))
  (get "https://httpbin.org/cookies/set/hello/world")
  (response-json (get "https://httpbin.org/cookies")))
 ((3) 0 () 0 () () (c values c (h - () (cookies h - () (hello u . "world")))))
 #""
 #"")
((for
  ((c
    (in-list (send jar cookies-matching (string->url "https://httpbin.org")))))
  (printf "~a: ~a" (ua-cookie-name c) (ua-cookie-value c)))
 ((3) 0 () 0 () () (c values c (void)))
 #"hello: world"
 #"")
((require racket/match) ((3) 0 () 0 () () (c values c (void))) #"" #"")
((match
  (get "https://example.com")
  ((response
    #:status-code
    200
    #:headers
    ((content-type (and (regexp #"text/html") the-content-type))))
   the-content-type))
 ((3) 0 () 0 () () (c values c (u . #"text/html; charset=UTF-8")))
 #""
 #"")
