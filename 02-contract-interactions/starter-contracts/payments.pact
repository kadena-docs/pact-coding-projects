;; Specify the namespace
(namespace 'free)

;; module-and-keyset
(define-keyset "free.admin-keyset" (read-keyset "admin-keyset"))

;define smart-contract code
(module payments "free.admin-keyset"

  ;; ========================================================
  ;;                    2.1-use-auth
  ;; ========================================================

  ;; use the auth module

  ;; --------------------END OF CHALLENGE -------------------

  ;; define-schemas-and-table
  (defschema accounts
    balance:decimal)

  (deftable accounts-table:{accounts})

  ;; ========================================================
  ;;                  2.2-create-account
  ;; ========================================================

  (defun create-account (userId initial-balance)
    "Create a new account for ID with INITIAL-BALANCE funds, must be administrator."
    ;; call enforce-user-auth from auth with parameter userId

    ;; --------------------END OF CHALLENGE -------------------
    (enforce (>= initial-balance 0.0) "Initial balances must be >= 0.")
    (insert accounts-table userId
            { "balance": initial-balance}))

  ;; ========================================================
  ;;                 2.3-get-balance
  ;; ========================================================

  (defun get-balance (userId)
    "Only admin can read balance."
    ;; call enforce-user-auth from auth with parameter admin

    ;; --------------------END OF CHALLENGE -------------------
    (with-read accounts-table userId
      { "balance":= balance }
      balance))

  ;; ========================================================
  ;;                    2.4-pay
  ;; ========================================================

  (defun pay (from to amount)
    (with-read accounts-table from { "balance":= from-bal }
      ;; call enforce-user-auth from auth with parameter from

      ;; --------------------END OF CHALLENGE -------------------
      (with-read accounts-table to { "balance":= to-bal }
        (enforce (> amount 0.0) "Negative Transaction Amount")
        (enforce (>= from-bal amount) "Insufficient Funds")
        (update accounts-table from
                { "balance": (- from-bal amount) })
        (update accounts-table to
                { "balance": (+ to-bal amount) })
        (format "{} paid {} {}" [from to amount]))))
)

;; create-table
(create-table accounts-table)
