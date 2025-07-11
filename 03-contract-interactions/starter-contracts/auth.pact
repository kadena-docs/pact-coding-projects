;; ===================================================================
;;  1 Define the namespace, two keysets, and module
;; ===================================================================
;; 
;; Define and enter a custom "dev" namespace.
(define-namespace "dev" (read-keyset "module-admin-keyset") (read-keyset "module-admin-keyset"))
(namespace "dev")

;; Define and read a keyset named module-admin.
(define-keyset "dev.module-admin" 
   (read-keyset "module-admin-keyset"))

;; Define and read a keyset named operate-admin.
(define-keyset "dev.operate-admin"
   (read-keyset "module-operate-keyset"))

;; Create a module named "auth" that is governed by the 
;; "module-admin" keyset guard.
(module auth AUTH
  (defcap AUTH ()
    (enforce-guard "dev.module-admin"))

;; ===================================================================
;;  2 Define the schema and table
;; ===================================================================

  ;; Define the "user" schema with columns for "nickname" as type 
  ;; string and "keyset" as type guard.
  (defschema user
     nickname:string
     keyset:guard)
  ;; Define the "users" table using the schema {user} you  
  ;; created.)
  (deftable users:{user})

;; ===================================================================
;;  3 Define functions
;; ===================================================================

  ;; Define a "create-user" function that takes arguments id, nickname, 
  ;; and keyset.
  (defun create-user:string (id:string nickname:string keyset:guard)
    ;; Enforce access to restrict function calls to the operate-admin.
    (enforce-guard "dev.operate-admin")
    ;; Insert a row into the "users-table" with the given id, nickname,
    ;; and keyset.
    (insert users id {
       "keyset": keyset,
       "nickname": nickname
     })
  )

  ;; Define the "enforce-user-auth" function that takes the id parameter.
  (defun enforce-user-auth:guard (id:string)
    ;; Read the users table to find the id, then bind value k to the 
    ;; keyset for the id.
    (with-read users id { "keyset":= k }
      ;; Enforce user authorization of data to the given keyset.
      (enforce-guard k)
      ;; Return the value of the keyset.
      k)
  )
;; End module declaration for the "auth" module.
) 
;; ===================================================================
;;  4 Create the table
;; ===================================================================
;;
;; Create the users table. 
(create-table users)       
