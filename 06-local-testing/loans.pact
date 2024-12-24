;; ------------------------------------------------
;; Namespace, keyset, module, and governance
;; ------------------------------------------------

(namespace "free")
   (define-keyset "free.loans-admin" (read-keyset "loans-admin"))

   (module loans LOAN_ADMIN
    (defcap LOAN_ADMIN ()
      (enforce-guard "free.loans.loans-admin"))

;; ------------------------------------------------
;; Table: loans
;; ------------------------------------------------

      (defschema loan
        loanName:string
        entityName:string
        loanAmount:integer
        status:string
    )

    (deftable loans:{loan})

;; ------------------------------------------------
;; Table: loan-history-table
;; ------------------------------------------------

    (defschema loan-history
      loanId:string
      buyer:string
      seller:string
      amount:integer
   )

   (deftable loan-history-table:{loan-history})

;; ------------------------------------------------
;; Table: loan-inventory-table
;; ------------------------------------------------

   (defschema loan-inventory
     balance:integer
   )

   (deftable loan-inventory-table:{loan-inventory})

;; ------------------------------------------------
;; Constants
;; ------------------------------------------------

   (defconst INITIATED "initiated")
   (defconst ASSIGNED "assigned")
  
;; ------------------------------------------------
;; Function: inventory-key
;; ------------------------------------------------

   (defun inventory-key (loanId:string owner:string)
     (format "{}:{}" [loanId owner])
   )

;; ------------------------------------------------
;; Function: create-a-loan
;; ------------------------------------------------

   (defun create-a-loan (loanId:string loanName:string entityName:string loanAmount:integer)
     (insert loans loanId {
       "loanName":loanName,
       "entityName":entityName,
       "loanAmount":loanAmount,
       "status":INITIATED
       })
   
     (insert loan-inventory-table (inventory-key loanId entityName)
       {
        "balance": loanAmount
       })
   )

;; ------------------------------------------------
;; Function: assign-a-loan
;; ------------------------------------------------

   (defun assign-a-loan (txid:string loanId:string buyer:string amount:integer)

     (with-read loans loanId {
       "entityName":= entityName,
       "loanAmount":= issuerBalance
      }

    (insert loan-history-table txid {
      "loanId":loanId,
      "buyer":buyer,
      "seller":entityName,
      "amount": amount
      }
    )
  
    (insert loan-inventory-table (inventory-key loanId buyer) {
      "balance":amount
      })
    (update loan-inventory-table (inventory-key loanId entityName){
      "balance": (- issuerBalance amount)
      }))
    (update loans loanId {
      "status": ASSIGNED
      })
   )

;; ------------------------------------------------
;; Function: sell-a-loan
;; ------------------------------------------------

   (defun sell-a-loan (txid:string loanId:string buyer:string seller:string amount:integer)
     (with-read loan-inventory-table (inventory-key loanId seller)
       {"balance":= prev-seller-balance}
     (with-default-read loan-inventory-table (inventory-key loanId buyer)    
       {"balance" : 0}
       {"balance":= prev-buyer-balance}
     (insert loan-history-table txid 
       {"loanId":loanId,
        "buyer":buyer,
        "seller":seller,
        "amount": amount
       }
     )
  
     (update loan-inventory-table (inventory-key loanId seller)
       {"balance": (- prev-seller-balance amount)})
     (write loan-inventory-table (inventory-key loanId buyer)
       {"balance": (+ prev-buyer-balance amount)}))))

;; ------------------------------------------------
;; Function: read-a-loan
;; ------------------------------------------------

    (defun read-a-loan (loanId:string)
      (read loans loanId))

;; ------------------------------------------------
;; Function: read-loan-tx
;; ------------------------------------------------

    (defun read-loan-tx ()
      (map (txlog loans) (txids loans 0)))

;; ------------------------------------------------
;; Function: read-all-loans
;; ------------------------------------------------

   (defun read-all-loans ()
     (select loans (constantly true)))

;; ------------------------------------------------
;; Function: read-inventory-pair
;; ------------------------------------------------

   (defun read-inventory-pair (key:string)
     {"inventory-key":key,
      "balance": (at 'balance (read loan-inventory-table key))}
   )

;; ------------------------------------------------
;; Function: read-loan-inventory
;; ------------------------------------------------

   (defun read-loan-inventory ()
     (map (read-inventory-pair) (keys loan-inventory-table)))

;; ------------------------------------------------
;; Function: read-loans-with-status
;; ------------------------------------------------

   (defun read-loans-with-status (status:string)
     (select loans (where "status" (= status)))
   )

;; ------------------------------------------------
;; Final parenthesis to close module declaration
;; ------------------------------------------------

)

;; ------------------------------------------------
;; Create tables
;; ------------------------------------------------

(create-table loans)
(create-table loan-inventory-table)
(create-table loan-history-table)
