;; Specify the namespace
(namespace 'free)

;; define-keysets
(define-keyset "free.module-admin"
  (read-keyset "module-admin-keyset"))

(define-keyset "free.operate-admin"
  (read-keyset "module-operate-keyset"))

;; define-module
(module auth "free.module-admin"

  ;; define-schema-and-table
  (defschema user
    nickname:string
    keyset:keyset
    )

  (deftable users:{user})

  ;; create-user
  (defun create-user (id nickname keyset)
    (enforce-keyset "free.operate-admin")
    (insert users id {
      "keyset": (read-keyset keyset),
      "nickname": nickname
      })
  )

  ;; ========================================================
  ;;                1.1-enforce-user-auth
  ;; ========================================================

  ;; define a function enforce-user-auth that takes a parameter id
  (defun enforce-user-auth (id)
  ;; read keyset from the users table of a given id. Bind this keyset to a variable k.
    (with-read users id { "keyset":= k }
  ;; enforce keyset of value k
      (enforce-keyset k)
     )
  )



)

;; create-table
(create-table users)
