(define-namespace 'ns-dev-local (read-keyset 'admin-keyset) (read-keyset 'admin-keyset))
(namespace 'ns-dev-local)
(define-keyset "ns-dev-local.admin-keyset" (read-keyset 'admin-keyset))

(module payments "ns-dev-local.admin-keyset"

  (defschema payments
    balance:decimal
    keyset:keyset)

    (deftable payments-table:{payments})

    (defun create-account (id initial-balance keyset)
      (enforce-keyset 'admin-keyset)
      (enforce (>= initial-balance 0.0) "Initial balances must be >= 0.")
      (insert payments-table id
        { "balance": initial-balance,
          "keyset": keyset })
    )

    (defun get-balance (id)
      (with-read payments-table id
        { "balance":= balance, "keyset":= keyset }
      (enforce-one "Access denied"
        [(enforce-keyset keyset)
         (enforce-keyset "ns-dev-local.admin-keyset")])
      balance)
    )

    (defun pay (from to amount)
      (with-read payments-table from { "balance":= from-bal, "keyset":= keyset }
        (enforce-keyset keyset)
        (with-read payments-table to { "balance":= to-bal }
          (enforce (> amount 0.0) "Negative transaction amount")
          (enforce (>= from-bal amount) "Insufficient funds")
          (update payments-table from
                  { "balance": (- from-bal amount) })
          (update payments-table to
                  { "balance": (+ to-bal amount) })
          (format "{} paid {} {}" [from to amount])
        )
      )
    )
)

(create-table payments-table)
