;;
;; "Hello, world!" smart contract/module
;;
;; In this example, the module defines a table for storing greeting messages
;; and two functions:
;; (set-message "message-string")
;; (greet)
;;

(namespace "free")

;; Define the module.
(module helloWorldMsgs MODULE_ADMIN
  "A smart contract to greet the world."

  ; Define a module admin capability to govern access for the contract.
  (defcap MODULE_ADMIN () true)

  ; Define the schema for the table that stores messages.
  (defschema message-schema
    @doc "Message schema"
    @model [(invariant (!= msg ""))]

    msg:string)

  (deftable
    message:{message-schema})

  (defun set-message
    (
      m:string
    )
    "Set the message that will be used next"
    ; uncomment the following to make the model happy!
    (enforce (!= m "") "set-message: must not be empty")
    (write message "0" {"msg": m})
  )

  (defun greet ()
    "Do the hello-world dance"
    (with-default-read message "0" { "msg": "" } { "msg":= msg }
      (format "Hello {}!" [msg])))
)

(create-table message)

