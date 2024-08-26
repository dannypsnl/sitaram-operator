#lang racket
(require racket/control)

(define example-tag (make-continuation-prompt-tag 'example))

(define (f)
  (println 1)
  (define r (fcontrol 'hi #:tag example-tag))
  (println r)
  (println 3))

(% (f)
   (lambda (v resume)
     (println v)
     (println 2)
     (resume 'hi))
   #:tag example-tag)
