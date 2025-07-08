;;
;; "Rotate authorized keys" module
;; 
;; ===================================================================
;;
;;  This file provides the framework for the different tasks you'll
;;  try to tackle in the "Rotate authorized keys" coding project.
;;
;;  This starter file provides a preview of the steps you'll follow to
;;  build the auth.pact final application.
;;
;; ===================================================================
;;  1 Define the namespace, two keysets, and module
;; ===================================================================
;; 
;; Define and enter a new namespace or enter an existing "free" 
;; namespace.

;; Define and read a keyset named module-admin.

;; Define and read a keyset named operate-admin.

;; Create a module named "auth" that is governed by the 
;; "module-admin" keyset guard.

;; ===================================================================
;;  2 Define the schema and table
;; ===================================================================

  ;; Define the "user" schema with columns for "nickname" as type 
  ;; string and "keyset" as type guard.

  ;; Define the "users-table" using the schema {user} you  
  ;; created.

;; ===================================================================
;;  3 Define functions
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

  ;; Define a "change-nickname" function that takes the parameters 
  ;; id and new-name.

    ;; Enforce user authorization for the id provided.

    ;; Update the nickname to the new-name for the given id.  

    ;; Return the message "Updated name for user [id] to [name]"

  ;; Define a "rotate-keyset" function that takes the parameters 
  ;; id and new-keyset.

      ;; Enforce user authorization for the id provided.

      ;; Update the keyset to the new-keyset for the given id.

      ;; Return the message "Updated keyset for user [id]"
  
;; ===================================================================
;;  4 Create the table
;; ===================================================================

;; Create the users-table.

;; ===================================================================
;;  5 Test the functions
;; ===================================================================

;; Create a test user (sarah) with a nickname and keyset.

;; Change the nickname for the test user.

;; Change the keyset for the test user.
