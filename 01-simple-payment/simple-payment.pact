;; ===================================================================
;;  1 Define a namespace, keyset, and module
;; ===================================================================
;; Define a local namespace controlled by admin-keyset.
(define-namespace "dev" (read-keyset "admin-keyset") (read-keyset "admin-keyset"))
;; Enter the namespace.
(namespace "dev")
;; Define the namespace keyset by reading admin-keyset.
(define-keyset "dev.admin-keyset" (read-keyset "admin-keyset"))
;; Create a module named payments that is governed by dev.admin-keyset.
(module payments "dev.admin-keyset"

;; ===================================================================
;;  2 Define schema and table
;; ===================================================================

  ;; Define the schema for payments including balance as type decimal 
  ;; and keyset as type guard.
  (defschema payments
    balance:decimal
    keyset:guard)
  ;; Define the payments-table using the schema {payments} you  
  ;; created.
  (deftable payments-table:{payments})

;; ===================================================================
;;  3 Define functions
;; ===================================================================

  ;; Define the create-account function with the parameters
  ;; id, initial-balance, and keyset.
  (defun create-account:string (id:string initial-balance:decimal keyset:guard)

    ;; Use enforce-guard to ensure that the account is created by 
    ;; the administrator.
    (enforce-guard "dev.admin-keyset")

    ;; Use enforce to ensure an initial-balance => 0.
    (enforce (>= initial-balance 0.0) "Initial balances must be >= 0.")

    ;; Insert the initial-balance and keyset into the payments-table.

    (insert payments-table id
      { "balance": initial-balance,
        "keyset": keyset })
  )

  ;; Define the get-balance function that takes an argument of id.
  (defun get-balance:decimal (id:string)
    ;; Uses with-read to view the id from the payments-table.
    (with-read payments-table id
      ;; - Bind the value of the balance and keyset of the given id 
      ;;   to variables named balance and keyset
      { "balance":= balance, "keyset":= keyset }

      ;; - Use enforce-one to check that the keyset calling the 
      ;;   function is the admin-keyset or the provided id keyset.

      (enforce-one "Access denied"
      [(enforce-guard keyset)
       (enforce-guard "dev.admin-keyset")])
    ;; Return the balance.
    balance)
  )

  ;; Define the pay function that takes parameters from, to, 
  ;; and amount.
  (defun pay:string (from:string to:string amount:decimal)
    ;; Use with-read to view the payments-table for the "from" account,
    ;; and bind the balance and keyset of this account to "from-bal" 
    ;; and "keyset" variables.
    (with-read payments-table from { "balance":= from-bal, "keyset":= keyset }
      ;; Enforce that the keyset is the keyset of the account.
      (enforce-guard keyset)
      ;; Use with-read to get the balance of the "to" account
      ;; and bind the balance to the "to-bal" variable named.
      (with-read payments-table to { "balance":= to-bal }
        ;; Enforce that the amount being transferred is greater 
        ;; than 0.
        (enforce (> amount 0.0) "Negative transaction amount")
        ;; Enforce that the balance of the user transferring value
        ;; is greater than what is being transferred.
        (enforce (>= from-bal amount) "Insufficient funds")
        ;; Update payments-table to reflect the new balance of 
        ;; the "from" account.
        (update payments-table from
           { "balance": (- from-bal amount) })
        ;; Update the payments-table to reflect the new balance 
        ;; of the "to-bal" account.
        (update payments-table to
           { "balance": (+ to-bal amount) })
        ;; Return a formatted string to say that the "from" account 
        ;; has paid the "to" account the amount paid.
        (format "{} paid {} {}" [from to amount])
      )
    )
  )
)
;; ===================================================================
;;  4 Create table
;; ===================================================================

;; Create the payments-table. This happens outside of the module. 
(create-table payments-table)
