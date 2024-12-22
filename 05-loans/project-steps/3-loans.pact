;; ===================================================================
;;  1-Define-module-and-keyset
;; ===================================================================

(namespace "free")
   (define-keyset "free.loans-admin" (read-keyset "loans-admin"))

   (module loans LOAN_ADMIN
    (defcap LOAN_ADMIN ()
      (enforce-guard "free.loans.loans-admin"))

;; ===================================================================
;;  2-Define-schemas-and-tables
;; ===================================================================

      (defschema loan
        loanName:string
        entityName:string
        loanAmount:integer
        status:string
    )

    (deftable loans:{loan})

    (defschema loan-history
      loanId:string
      buyer:string
      seller:string
      amount:integer
   )
   
   (deftable loan-history-table:{loan-history})

   (defschema loan-inventory
     balance:integer
   )

   (deftable loan-inventory-table:{loan-inventory})

;; ===================================================================
;;  3-Define-constants
;; ===================================================================

   (defconst INITIATED "initiated")
   (defconst ASSIGNED "assigned")
  
 )