;; ===================================================================
;;  1 Define module and keyset
;; ===================================================================
;;
;; For this project, the "my-coin" module represents a simple ledger 
;; system with functions to create accounts, credit, debit, transfer,
;; and look up account balances.

;; The module also includes a points table and functions to illustrate 
;; safe if and cond expressions. 
  
(define-keyset "coin-admin-keyset" (read-keyset "coin-admin-keyset"))

(module my-coin COIN-ADMIN
  (defcap COIN-ADMIN ()
    (enforce-guard "coin-admin-keyset"))

;; ===================================================================
;;  2 Define schemas and tables
;; ===================================================================

 (defschema my-points
    balance:integer
 )

 (deftable my-points-table:{my-points})

 (defschema my-coin-schema
    balance:decimal
    keyset:guard)

 (deftable my-coin-table:{my-coin-schema})

 (defun create-user:string (user:string)
   (insert my-points-table user
     { "balance" : 0}
   )
 )

 (defun play:string (user:string)
   (with-read my-points-table user
     { "balance" := points }
      (update my-points-table user
     { "balance" : (+ 1 points)})
   )
 )

 (defun check-points:integer (user:string)
   (with-read my-points-table user
     { "balance" := points }
    points
   )
 )

 (defun check-condition:string (user:string)
   (with-read my-points-table user
     { "balance" := points }
       (cond ((= 0 points) "New user") ((< points 10) "Play again") (do (+ 1 points) "Bonus points"))
   )
 )

 (defconst VIP_UNLOCK 10)

 (defun unlock-access:string (user:string contribution:integer)
   (with-read my-points-table user
      { "balance" := access-points }
      (update my-points-table user
        { "balance" : (+ access-points contribution)})
          (if (>= access-points VIP_UNLOCK)
             (format "Congratulations! You have {} points and unlocked VIP access." [access-points])
             (format "Sorry, you need {} more points to unlock!" [(- VIP_UNLOCK access-points)])
          )
    )
 )

(defun account-balance (account:string)
   (with-read my-coin-table account
     { "balance" := balance }
     balance
   )
 )

 (defun create-account:string (account:string keyset:keyset)
    (insert my-coin-table account
      { "balance" : 0.0
      , "keyset" : keyset
      })
    )

  ;; Create a debit-if function that uses if expressions.
  (defun debit-if:string (account:string amount:decimal)
     (with-read my-coin-table account
        { "balance" := balance }
        ;; Check if balance is sufficient for the transfer.
        (if (> balance amount)
          ;; If the condition is true, update my-coin-table.
          (update my-coin-table account
            { "balance" : (- balance amount) })
          ;; If the condition is false, print a message.
          "Balance is not sufficient for transfer" )
      )
  ) 
 
  ;; Refactor with enforce
  (defun debit:string (account:string amount:decimal)
    (with-read my-coin-table account
        { "balance" := balance }
        ;; Enforce the condition, and fail the transaction if the condition isn't met.
        (enforce (> balance amount) "Balance is not sufficient for transfer")
        ;; Update the balance.
        (update my-coin-table account
          { "balance" : (- balance amount) })
    )
  )

  ;; Create a credit function that uses if expressions
  (defun credit-if:string (account:string keyset:keyset amount:decimal)
    ;; Fetch all keys in my-coin-table and see if account exists.
    (if (contains account (keys my-coin-table))

    ;; if the row exists, check keyset.
    (with-read my-coin-table account 
       { "balance":= balance,
         "keyset":= retk }
       ;; If the keysets match, update the balance.
       ;; Otherwise, print an error message.
       (if (= retk keyset)
         (update my-coin-table account {
           "balance": (+ amount balance)})
           "Keysets do not match" ))
    ;;if the row does not exist, insert a row into the table.
    (insert my-coin-table account{
       "balance": amount,
       "keyset": keyset
      }
    )
  )
)

  ;; Refactor the credit function with with-default-read, write, and enforce.
  (defun credit:string (account:string keyset:keyset amount:decimal)
    (with-default-read my-coin-table account
      { "balance": 0.0, "keyset": keyset }
      { "balance":= balance, "keyset":= retg }
      ;; Check that the input keyset is the same as the row's keyset
      (enforce (= retg keyset)
        "account guards do not match")
      ;; Write the row to the table.
      (write my-coin-table account
        { "balance" : (+ balance amount)
        , "keyset"   : retg
        }
      )
    )
  )
)

(create-table my-points-table)

(create-table my-coin-table)
