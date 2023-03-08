  ::  band (stripe integration)
::::
::    hoon structures for stripe api integration
::
|%
+$  api-key         @t                                  ::  stripe api key
+$  price           @ud                                 ::  price in cents
+$  customer        @
+$  paid            ?                                   ::  payment status
+$  customers       (map customer paid)
--
