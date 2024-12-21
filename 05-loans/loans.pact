(namespace "free")
   (define-keyset "free.loans-admin" (read-keyset "loans-admin"))

   (module loans LOAN_ADMIN
    (defcap LOAN_ADMIN ()
      (enforce-guard "free.loans.loans-admin"))
   
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

   (defconst INITIATED "initiated")
   (defconst ASSIGNED "assigned")
  
;; ------------------------------------------------
;; inventory-key
;; ------------------------------------------------

   (defun inventory-key (loanId:string owner:string)
     (format "{}:{}" [loanId owner])
   )

;; ------------------------------------------------
;; create-a-loan
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
;; assign-a-loan
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
;; sell-a-loan
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
;; read-a-loan
;; ------------------------------------------------

    (defun read-a-loan (loanId:string)
      (read loans loanId))

;; ------------------------------------------------
;; read-loan-tx
;; ------------------------------------------------

    (defun read-loan-tx ()
      (map (txlog loans) (txids loans 0)))

;; ------------------------------------------------
;; read-all-loans
;; ------------------------------------------------

   (defun read-all-loans ()
     (select loans (constantly true)))

;; ------------------------------------------------
;; read-inventory-pair
;; ------------------------------------------------

   (defun read-inventory-pair (key:string)
     {"inventory-key":key,
      "balance": (at 'balance (read loan-inventory-table key))}
   )

;; ------------------------------------------------
;; read-loan-inventory
;; ------------------------------------------------

   (defun read-loan-inventory ()
     (map (read-inventory-pair) (keys loan-inventory-table)))

;; ------------------------------------------------
;; read-loans-with-status
;; ------------------------------------------------

   (defun read-loans-with-status (status:string)
     (select loans (where "status" (= status)))
   )
;; Final parenthesis to close the module Declaration
)


(create-table loans)
(create-table loan-inventory-table)
(create-table loan-history-table)
