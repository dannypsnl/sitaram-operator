#lang racket
(require racket/control)

(define raise-tag (make-continuation-prompt-tag 'raise))
(define (raise e) (fcontrol e #:tag raise-tag))

(define-syntax (try stx)
  (syntax-case stx ()
    [(_ body handler)
     #'(% body
          (λ (e _)
            (handler e))
          #:tag raise-tag)]))

(define (f2)
  (println "f2 do something")
  (raise 'fail))
(try (f2)
     (λ (err)
       (println "f2 failed")
       (println err)))


(define log-tag (make-continuation-prompt-tag 'log))
(define (log message) (fcontrol message #:tag log-tag))
(define-syntax (with-log stx)
  (syntax-case stx ()
    [(_ body handler)
     #'(% body
          (λ (msg resume)
            (handler msg)
            (resume))
          #:tag log-tag)]))

(define (f3)
  (log "f3 do something")
  (raise 'fail))
(try (with-log (f3)
       (λ (msg)
         (println msg)))
     (λ (err)
       (println "f2 failed")
       (println err)))
