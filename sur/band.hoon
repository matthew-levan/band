  ::  band (stripe integration)
::::
::    hoon structures for stripe api integration
::
|%
+$  api-key         @t                                  ::  stripe api key
+$  price-id        @t                                  ::  stripe product's price_id
+$  customer        @
+$  paid            ?                                   ::  payment status
+$  customers       (map customer paid)
--
