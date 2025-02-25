;
;; "Loans" module
;; 
;; ===================================================================
;;
;;  This file provides the framework for the different tasks you'll
;;  try to tackle in the "Loans" coding project.
;;
;;  This starter file provides a preview of the steps you'll follow to
;;  build the loans.pact final application.
;;
;; ===================================================================
;;  1-Define-module-and-keyset
;; ===================================================================

;; Specify the namespace for the module.

;; Define and read a keyset named "loan-admin" for the module.

;; Create a module named "loans" that is governed by the 
;; "loan-admin" guard.

;; ===================================================================
;;  2-Define-schemas-and-tables
;; ===================================================================

;; Define the "loan" schema with the following columns and types:

    ;; column loanName of type string
    ;; column entityName of type string
    ;; column loanAmount of type integer
    ;; column status of type string

    ;; Define the "loans" table that uses the "loans" schema

;; Define the "loan-history" schema with the following columns and types:

    ;; column loanId of type string
    ;; column buyer of type string
    ;; column seller of type string
    ;; column amount of type integer

    ;; Define the "loan-history-table" that uses the "loan-history" schema.

;; Define the "loan-inventory" schema with the following column and type:

    ;; column balance of type integer
    
    ;; Define the "loan-inventory-table" that uses the "loan-inventory" schema.

;; ===================================================================
;;  3-Define-constants
;; ===================================================================

  ;; Define the INITIATED constant with the comment "initiated".

  ;; Define the ASSIGNED constantwit the comment "assigned".


;; ===================================================================
;;  4-Define-functions: "inventory-key"
;; ===================================================================
  
  ;; Define the "inventory-key" function named that takes inputs: 
  ;; loanId:string and owner:string.

     ;; Format a composite key from OWNER and LoanId in the format 
     ;; "loanId:owner".

;; ===================================================================
;;  4-Define-functions: "create-a-loan"
;; ===================================================================
  
  ;; Define the "create-a-loan" function that takes the parameters: 
  ;; loanId, loanName, entityName, and loanAmount

    ;; Insert data into "loans" table using the loanId

      ;; Insert "loanName" as value of loanName

      ;; Insert "entityName" as value of entityName

      ;; Insert "loanAmount" as value of loanAmount

      ;; Insert "status" as value INITIATED

    ;; Insert to "loan-inventory-table" with the parameters:
    ;; inventory-key, loanId, and entity name

      ;; Insert "balance" as value loanAmount

;; ===================================================================
;;  4-Define-functions: "assign-a-loan"
;; ===================================================================

  ;; Define the "assign-a-loan" function that takes parameters: txid, 
  ;; loanId, buyer, and amount.

    ;; Read from "loans" table using loanId

      ;; Bind "entityName" to the value of entityName

      ;; Bind "loanAmount" to the value of issuerBalance

      ;; Insert into loan-history-table using the value of txid

        ;; Insert "loanId" as value of loanId

        ;; Insert "buyer" as value of buyer

        ;; Insert "seller" as value of entityName

        ;; Insert "amount" as value of amount

      ;; Insert to "loan-inventory-table" with the parameters:
      ;; inventory-key, loanId, and buyer

        ;; Insert "balance" as value of amount

      ;; Update "loan-inventory-table" with the parameters:
      ;; inventory-key, loanId, and entityName

        ;; Update new balance of the issuer in the inventory table

      ;; Update "loans" table using loanId

        ;; update "status" to value ASSIGNED

;; ===================================================================
;;  4-Define-functions: "sell-a-loan"
;; ===================================================================

  ;; Define the "sell-a-loan" function that takes parameters: 
  ;; txid, loanId, buyer, seller, and amount.

    ;; Read from loan-inventory-table using paramters:
    ;; inventory-key, loanId, and seller.

      ;; Bind "balance" to value of prev-seller-balance

      ;; Read from loan-inventory-table with parameters:
      ;; inventory-key, loanId, and buyer.

        ;; Assign "balance" to 0.

        ;; Bind "balance" to value of prev-buyer-balance.

      ;; Insert to loan-history-table at the given txid.

        ;; Insert "loanId" as value of loanId.

        ;; Insert "buyer" as value of buyer.

        ;; Insert "seller" as value of seller.

        ;; Insert "amount" as value of amount.

      ;; Update the "loan-inventory-table" with parameters:
      ;; inventory-key, loanId, and seller

        ;; Set "balance" the previous-seller-balance minus the amount

      ;; Write to the "loan-inventory-table" with parameters:
      ;; inventory-key, loanId, and buyer

        ;; Set "balance" the previous-seller-balance plus the amount

;; ===================================================================
;;  4-Define-functions: "read-a-loan"
;; ===================================================================

  ;; Define the "read-a-loan" function that takes the parameter loanId.

  ;; Read all values of the "loans" table at the given loanId.

;; ===================================================================
;;  4-Define-functions: "read-all-loans"
;; ===================================================================

  ;; Define the "read-all-loans" function that takes no parameters.

    ;; Select all values from the loans-table with constantly set 
    ;; to true.

;; ===================================================================
;;  4-Define-functions: "read-inventory-pair"
;; ===================================================================

  ;; Define the "read-inventory-pair" function takes a parameter 
  ;; named key.

    ;; Set "inventory-key" to the provided key.

     ;; Set "balance" the value of the balance of "loan-inventory-table" 
     ;; at the value of the key

;; ===================================================================
;;  4-Define-functions: "read-loan-inventory"
;; ===================================================================

  ;; Define the "read-loan-inventory" function that takes no parameters.

    ;; Map the value of "read-inventory-pair" to the keys of the 
    ;; "loan-inventory-table".

;; ===================================================================
;;  4-Define-functions: "read-loans-with-status"
;; ===================================================================

  ;; Define the "read-loans-with-status" function that takes the
  ;; parameter status.

    ;; Select all values from the "loans" table where "status" equals 
    ;; the parameter status.


;; Close the module declaration

;; ===================================================================
;;  4-Create-tables
;; ===================================================================

;; Create loans-table.

;; Create "loans-history-table".

;; Create "loans-inventory-table".
