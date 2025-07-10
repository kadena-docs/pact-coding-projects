;; ===================================================================
;;  1 Define the namespace, keyset, and module
;; ===================================================================
;; 
;; Define and enter a custom "dev" namespace.
(define-namespace "dev" (read-keyset "module-admin-keyset") (read-keyset "module-admin-keyset"))
(namespace "dev")

;; Define and read a keyset named module-admin.
(define-keyset "dev.module-admin" (read-keyset "module-admin-keyset"))

;; Create the "payments" module that is governed by the "module-admin" keyset guard.
(module payments ADMIN
  (defcap ADMIN ()
    (enforce-guard "dev.module-admin"))

;; ===================================================================
;;  2 Import the "auth" module 
;; ===================================================================
;;
;; Use the "auth" module.

;; ===================================================================
;;  2 Define the schema and table
;; ===================================================================

  ;; Define the "account" schema with one column for "balance" as type 
  ;; decimal.
  (defschema account
    balance:decimal)
  
  ;; Define the "accounts" table that uses the {account} schema. 
  (deftable accounts:{account})

;; ===================================================================
;;  3 Define functions that call the "auth" module functions.
;; ===================================================================
  
  ;; Define the create-account function.
  (defun create-account:string (userId:string initial-balance:decimal)
    "Create a new account for ID with INITIAL-BALANCE funds, must be administrator."
    ;; call enforce-user-auth from auth with parameter userId

    ;; --------------------END OF CHALLENGE -------------------
    (enforce (>= initial-balance 0.0) "Initial balances must be >= 0.")
    (insert accounts userId
            { "balance": initial-balance}))

  ;; Define the get-balance function
  (defun get-balance:decimal (userId:string)
    "Only admin can read balance."
    ;; call enforce-user-auth from auth with parameter admin

    ;; --------------------END OF CHALLENGE -------------------
    (with-read accounts userId
      { "balance":= balance }
      balance))

  ;; Define the pay function.
  (defun pay:string (from:string to:string amount:decimal)
    (with-read accounts from { "balance":= from-bal }
      ;; call enforce-user-auth from auth with parameter from

      ;; --------------------END OF CHALLENGE -------------------
      (with-read accounts to { "balance":= to-bal }
        (enforce (> amount 0.0) "Transaction amount cannot be negative.")
        (enforce (>= from-bal amount) "Insufficient funds")
        (update accounts from
                { "balance": (- from-bal amount) })
        (update accounts to
                { "balance": (+ to-bal amount) })
        (format "{} paid {} {}" [from to amount]))))
)
;; ===================================================================
;;  4 Create the "accounts" table.
;; ===================================================================
  
(create-table accounts)
