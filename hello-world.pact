;;
;; "Hello, world!" smart contract/module
;;
 
;;---------------------------------
;;
;;  Create an 'admin-keyset' and add some key, for loading this contract!
;;
;;  Make sure the message is signed with this added key as well.
;;
;;---------------------------------
 
;; Keysets cannot be created in code, thus we read them in
;; from the load message data.
(define-keyset 'admin-keyset {
        "keys": [
            "1d5a5e10eb15355422ad66b6c12167bdbb23b1e1ef674ea032175d220b242ed4"
        ],
        "pred": "keys-all"
    }
)
 
;; Define the module.
(module helloWorld 'admin-keyset
 "A smart contract to greet the world."
 (defun hello (name)
   "Do the hello-world dance"
   (format "Hello {}!" [name]))
)
 
;; and say hello!
(hello "world")
 
