(namespace "free")

(module test-gas GOVERNANCE
   (defcap GOVERNANCE () 
     (enforce-guard "free.dev-account"))


   (implements gas-payer-v1)
   (defcap GAS_PAYER:bool
     ( user  : string
       limit : integer
       price : decimal
     )

    (enforce-one
       "Allow the administrator to use the gas station account for any transaction."
       [
         (enforce-guard  "free.dev-account" )
         (enforce (<= 0.00000001 (at 'gas-price (chain-data)))
           "Gas price must be less than 0.00000001"
         )
       ]
     )

     (compose-capability (ALLOW_GAS))
  )

  (defcap ALLOW_GAS () true)

  (defun create-gas-payer-guard:guard ()
    (create-capability-guard (free.test-gas.ALLOW_GAS))
  )

  (defconst GAS_ACCOUNT (create-principal (create-gas-payer-guard)))

  (defun init ()
     (coin.create-account GAS_ACCOUNT (create-gas-payer-guard))
  )
  (defun display:object ()
     (coin.details free.test-gas.GAS_ACCOUNT)
  )
  
)

(if (read-msg "init")
  [(init)]
  ["Not creating the gas station account"]
)

(free.test-gas.display)