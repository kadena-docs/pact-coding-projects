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
    
  (use auth)

  ;; Define the "account" schema with one column for "balance" as type 
  ;; decimal.
  (defschema account
    balance:decimal)
  
  ;; Define the "accounts" table that uses the {account} schema. 
  (deftable accounts:{account})

;; Define the create-account function.
  (defun create-account:string (userId:string initial-balance:decimal)
    "Create a new account for ID with INITIAL-BALANCE funds, must be administrator."
    (enforce-user-auth userId)
    (enforce (>= initial-balance 0.0) "Initial balances must be >= 0.")
    (insert accounts userId
            { "balance": initial-balance}))

;; Define the get-balance function
  (defun get-balance:decimal (userId:string)
    "Only admin can read balance."
    (enforce-user-auth "admin")
    (with-read accounts userId
      { "balance":= balance }
      balance))

;; Define the pay function.
  (defun pay:string (from:string to:string amount:decimal)
    (with-read accounts from { "balance":= from-bal }
      (enforce-user-auth from)
      (with-read accounts to { "balance":= to-bal }
        (enforce (> amount 0.0) "Transaction amount cannot be negative.")
        (enforce (>= from-bal amount) "Insufficient funds")
        (update accounts from
                { "balance": (- from-bal amount) })
        (update accounts to
                { "balance": (+ to-bal amount) })
        (format "{} paid {} {}" [from to amount]))))
)

;; Create "accounts" table
(create-table accounts)
