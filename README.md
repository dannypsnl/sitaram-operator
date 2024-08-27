# Sitaram’s operators examples

This repository are examples of Sitaram's operators.

## Limitation

In the example _log_

```racket
(define (g)
  (log "g do something")
  (raise 'fail))
```

since first `log` already consume the handler, second call to `log` will find no corresponding prompt in the continuation.
