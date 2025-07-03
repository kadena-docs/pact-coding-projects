;;
;; "Simple payments" module
;; 
;; ===================================================================
;;
;;  This file provides the framework for the different tasks you'll
;;  try to tackle in the "Simple payments" coding project.
;;
;;  This starter file provides a preview of the steps you'll follow to
;;  build the simple-payment.pact final application.
;;
;; ===================================================================
;;  1 Define a namespace, keyset, and module
;; ===================================================================

;; Define and enter a principal namespace or local developer namespace.

;; Define and read a keyset named "admin-keyset" for the namespace.

;; Create a module named "payments" that is governed by the 
;; "admin-keyset" guard.

;; ===================================================================
;;  2 Define schema and table
;; ===================================================================

  ;; Define the schema for "payments" with columns "balance" as type 
  ;; decimal and keyset as type guard.

  ;; Define the "payments-table" using the {payments} schema.

;; ===================================================================
;;  3 Define functions
;; ===================================================================

  ;; Define the "create-account" function with the parameters
  ;; id, initial-balance, and keyset.

    ;; Use "enforce-guard" to ensure that the account is created by 
    ;; the administrator.

    ;; Use "enforce" to ensure an initial-balance => 0.

    ;; Insert the id, initial-balance, and keyset into the 
    ;; "payments-table".


  ;; Define the "get-balance" function that takes an argument of id.

    ;; Use "with-read" to view the id from the "payments-table" and
      ;; bind the value of the balance and keyset for the given id 
      ;; to "balance" and "keyset" variables.

      ;; Use "enforce-one" to check that the keyset calling the 
      ;; function is the admin-keyset or the provided id keyset.

    ;; Return the balance.


  ;; Define the "pay" function that takes parameters from, to, 
  ;; and amount.

    ;; Use "with-read" to view the payments-table for the "from" account, 
      ;; and bind the balance and keyset of this account to "from-bal" 
      ;; and "keyset" variables.

      ;; Enforce that the keyset is the keyset of the account.

      ;; Use "with-read" to get the balance of the "to" account, 
        ;; and bind the balance to the "to-bal" variable.

        ;; Enforce that the amount being transferred is greater 
        ;; than 0.

        ;; Enforce that the balance for the user transferring value
        ;; is greater than what is being transferred.

        ;; Update the payments-table to reflect the new balance of 
        ;; the "from" account.

        ;; Update the payments-table to reflect the new balance 
        ;; of the "to-bal" account.

        ;; Return a formatted string to say that the "from" account 
        ;; has paid the "to" account the amount paid.

;; ===================================================================
;;  4 Create table
;; ===================================================================

;; Create the payments-table.

;; ===================================================================
;;  5 Create accounts
;; ===================================================================

;; Create the Sarah account with initial value of 100.25.

;; Create the James account with initial value of 250.0.

;; ===================================================================
;;  6 Make payment
;; ===================================================================

;; Call the "pay" function to pay 25.0 from Sarah to James.

;; ===================================================================
;;  7 Get balances
;; ===================================================================

;; Read Sarah's balance as Sarah.

;; Read James' balance as James.

