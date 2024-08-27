#lang racket
(require racket/control
         (for-syntax syntax/parse))

(define raise-tag (make-continuation-prompt-tag 'raise))
(define (raise e) (fcontrol e #:tag raise-tag))

(define-syntax (try stx)
  (syntax-parse stx
    [(_ body handler)
     #'(% body
          (λ (e _)
            (handler e))
          #:tag raise-tag)]))

(define (f)
  (println "f do something")
  (raise 'fail))
(try (f)
     (λ (err)
       (println "f failed")
       (println err)))


(define log-tag (make-continuation-prompt-tag 'log))
(define (log message) (fcontrol message #:tag log-tag))
(define-syntax (with-log stx)
  (syntax-parse stx
    [(with-log body handler)
     #'(% body
          (λ (msg resume)
            (handler msg)
            (resume))
          #:tag log-tag)]))

(define (g)
  (log "g do something")
  (raise 'fail))
(try (with-log (g)
       (λ (msg)
         (println msg)))
     (λ (err)
       (println "g failed")
       (println err)))
