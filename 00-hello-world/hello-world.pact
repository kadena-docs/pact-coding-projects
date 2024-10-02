;;
;; "Hello, world!" module
;; 
;;-----------------------------------------------------------------------
;;
;;  Use semicolons (;) for comments in smart contracts.
;;  By convention, use:
;;  
;;  - A single semicolon (;) for short notes on a single line of code. 
;;  - Two semicolons (;;) to describe functions or other top-level forms.
;;  - Three semicolons (;;;) to separate larger sections of code.
;;
;;-----------------------------------------------------------------------

(module helloWorld GOVERNANCE
    "You can also embed comments in smart contracts by using quoted strings."

    (defcap GOVERNANCE () true)
      (defun say-hello(name:string)
        (format "Hello, {}! ~ from Kadena" [name])
    )
)
