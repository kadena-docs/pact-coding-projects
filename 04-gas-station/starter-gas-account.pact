;;
;; "Add a gas station account" module
;; 
;; ===================================================================
;;
;;  This file provides the framework for the different tasks you'll
;;  try to tackle in the "Add a gas station account" coding project.
;;
;;  This starter file provides a preview of the steps you'll follow to
;;  build the gas-account.pact final application.
;;
;; ===================================================================
;;  1 Define module and governance
;; ===================================================================

;; Enter the "free" namespace to create a module named "test-gas" that 
;; is governed by the "GOVERNANCE" capability.

;; ===================================================================
;;  2 Implement the gas-payer-v1 interface
;; ===================================================================

  ;; Implement the gas-payer-v1 interface that defines a GAS_PAYER
  ;; capability that allows gas to be paid on behalf of a USER for gas 
  ;; LIMIT and PRICE.
  
  ;; Compose an ALLOW_GAS capability for the "create-gas-payer-guard" 
  ;; function.

;; ===================================================================
;;  3 Define the capability guard account
;; ===================================================================

  ;; Define the "create-gas-payer-guard" function to create a
  ;; capability guard for the ALLOW_GAS capabilty.

  ;; Define a constant to hold the capability guard principal 
  ;; account.
  
  ;; Define an "init" function to create a coin contract account for
  ;; the capability-guarded principal account.
  
  ;; Add an expression to call the "init" function to initialize the
  ;; capability-guarded principal account.

;; ===================================================================
;;  4 Add limits to the GAS_PAYER capability
;; ===================================================================

;; Enforce a limit that allows the designated administrator to use 
;; the gas station account for any transaction.

;; Enforce a gas price limit for all other users and transactions.

;; ===================================================================
;;  5 Add a function to verify the gas station account
;; ===================================================================

;; Define a "display" function that calls the "coin.details" to
;; verify the gas station account has been successfully created.

;; ===================================================================
;;  6 Deploy the test-gas module
;; ===================================================================

;; Deploy the "test-gas" module in the "free" namespace on the 
;; development network.

;; Verify the transaction results in the block explorer.

;; ===================================================================
;;  7 Fund the account
;; ===================================================================

;; Create a transfer transaction to add funds to the gas station 
;; account from the gas station administrator's account.
