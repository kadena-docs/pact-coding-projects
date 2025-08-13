;;
;; "Conditions and control flow" coding project
;; 
;; ===================================================================
;;
;;  This file provides the framework for the writing conditional
;;  expressions in the "Conditions and control flow" coding project.
;;
;;  This starter file provides a preview of the steps you'll follow to
;;  build the control-flow.pact final application.
;;
;; ===================================================================
;;  1 Define module and keyset
;; ===================================================================
;;
;; For this project, the "my-coin" module represents a simple ledger 
;; system with functions to create accounts, credit, debit, transfer,
;; and look up account balances.
  
(define-keyset "coin-admin-keyset" (read-keyset "coin-admin-keyset"))

(module my-coin COIN-ADMIN
  (defcap COIN_ADMIN ()
    (enforce-guard "coin-admin-keyset"))

;; ===================================================================
;;  2 Define schemas and tables
;; ===================================================================
;;
;; (defschema my-points
;;    balance:integer
;; )
;;
;; (deftable my-points-table:{my-points})
;;
   (defschema my-coin-schema
      balance:decimal
      keyset:guard)

   (deftable my-coin-table:{my-coin-schema})

;; ===================================================================
;;  3 Define functions for points and coins
;; ===================================================================
;;
;; (defun create-user:string (user:string)
;;   (insert my-points-table user
;;     { "balance" : 0}
;;   )
;; )
;;
;; (defun play:string (user:string)
;;   (with-read my-points-table user
;;     { "balance" := points }
;;      (update my-points-table user
;;     { "balance" : (+ 1 points)})
;;   )
;; )
;;
;; (defun check-points:integer (user:string)
;;   (with-read my-points-table user
;;     { "balance" := points }
;;    points
;;   )
;; )
;;
;; (defun check-condition:string (user:string)
;;   (with-read my-points-table user
;;     { "balance" := points }
;;       (cond ((= 0 points) "New user") ((< points 10) "Play again") (do (+ 1 points) "Bonus points"))
;;   )
;; )
;;
;; (defconst VIP_UNLOCK 10)
;;
;; (defun unlock-access:string (user:string contribution:integer)
;;   (with-read my-points-table user
;;      { "balance" := access-points }
;;      (update my-points-table user
;;       { "balance" : (+ access-points contribution)})
;;         (if (>= access-points VIP_UNLOCK)
;;           (format "Congratulations! You have {} points and unlocked VIP access." [access-points])
;;           (format "Sorry, you need {} more points to unlock!" [(- VIP_UNLOCK access-points)])
;;      )
;;    )
;; )

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

          ;; STEP 1: Check if balance is sufficient for the transfer.
          
          ;; STEP 2: If condition is true, update my-coin-table.

          ;; STEP 3: If condition is false, print a message.

     )
  )

  ;; Refactor with enforce
  (defun debit:string (account:string amount:decimal)
    (with-read my-coin-table account
        { "balance" := balance }

        ;; STEP 1: Enforce the condition, and fail the transaction if the condition isn't met.

        ;; STEP 2: Update the balance.

    )
  )

  ;; Create a credit function that uses if expressions
  (defun credit-if:string (account:string keyset:keyset amount:decimal)

   ;; STEP 1: Fetch all keys in my-coin-table and see if the "account" exists.

    ;; STEP 2: if the row exists, check keyset.

       ;; STEP 3: If the keysets match, update the balance.
       ;; Otherwise, print an error message.

    ;; STEP 4: If the row does not exist, insert a new row into the table.

  )

  ;; Refactor the credit function with with-default-read, write, and enforce.
  (defun credit:string (account:string keyset:keyset amount:decimal)

    ;; STEP 1: Set the default the balance to 0.0 and use the keyset as input.
    ;; If the row exists, bind "balance" and "keyset" value from the table.
    ;; This allows one time key lookup - increases efficiency.
    
      ;; STEP 2: Check that the input keyset is the same as the row's keyset.

      ;; STEP 3: Write the row to the table.

  )
)
;; (create-table my-points-table)

(create-table my-coin-table)
