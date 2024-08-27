#lang racket
(require racket/control)

(define example-tag (make-continuation-prompt-tag 'example))

(define (f)
  (println 1)
  (define r (fcontrol 2 #:tag example-tag))
  (println r)
  (println 5))

(% (f)
   (lambda (v resume)
     (println v)
     (println 3)
     (resume 4))
   #:tag example-tag)
