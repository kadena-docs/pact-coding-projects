;;
;; "Contract interaction" coding project
;; 
;; ===================================================================
;;
;;  This file provides the framework for the different tasks you'll
;;  try to tackle in the "Contract interaction" coding project.
;;
;;  This starter file provides a preview of the steps you'll follow to
;;  build the final application with two modules.
;;
;; ===================================================================
;;  1 Define the "auth" module in a namespace with two keysets
;; ===================================================================
;; 
;; Define and enter a new namespace or enter an existing "free" 
;; namespace.

;; Define and read a keyset named module-admin.

;; Define and read a keyset named operate-admin.

;; Create a module named "auth" that is governed by the 
;; "module-admin" keyset guard.

;; ===================================================================
;;  2 Define the "user" schema and "users" table
;; ===================================================================

  ;; Define the "user" schema with columns for "nickname" as type 
  ;; string and "keyset" as type guard.

  ;; Define the "users" table that uses the {user} schema you  
  ;; created.

;; ===================================================================
;;  3 Define authorization functions
;; ===================================================================

  ;; Define a "create-user" function that takes arguments id, nickname, 
  ;; and keyset.

    ;; Enforce access to restrict function calls to the operate-admin.

    ;; Insert a row into the "users-table" with the given id, nickname,
    ;; and keyset.

  ;; Define the "enforce-user-auth" function that takes the id parameter.

    ;; Read the users-table to find the id, then bind value k to the 
    ;; keyset for the id.

      ;; Enforce user authorization of data to the given keyset.

      ;; Return the value of the keyset.
  
;; ===================================================================
;;  4 Create the "users" table
;; ===================================================================

;; Create the "users" table.

;; ===================================================================
;;  5 Define the "payments" module in a namespace with one keyset
;; ===================================================================

;; Enter the same namespace as the "auth" module.
;;
;; Define and read a keyset named "module-admin".
;;
;; Import the "auth" module.
;;
;; Define the "account" schema and "accounts" table.
;;
;; Add functions that use the "auth" module to the "payments" module.
;;
;; Create the "accounts" table.

;; ===================================================================
;;  5 Test the functions
;; ===================================================================

