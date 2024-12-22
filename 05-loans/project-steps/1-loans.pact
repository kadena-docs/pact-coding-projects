;; ===================================================================
;;  1-Define-module-and-keyset
;; ===================================================================

(namespace "free")
   (define-keyset "free.loans-admin" (read-keyset "loans-admin"))

   (module loans LOAN_ADMIN
    (defcap LOAN_ADMIN ()
      (enforce-guard "free.loans.loans-admin"))

   )