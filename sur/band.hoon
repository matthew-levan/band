  ::  band (stripe integration)
::::
::    hoon structures for stripe api integration
::
|%
+$  api-key         @t                                  ::  stripe api key
+$  price           @ud                                 ::  price in cents
+$  customer        @                                   ::  
+$  payment-intent  @t
+$  customers       (map customer payment-intent)
+$  product
  $:  name=@t
      description=@t
      =price
      price-id=@t
  ==
+$  update
  $%  [%checkout =price quantity=@ud]
      [%stripe-auth =api-key]
  ==
+$  action
  $%  [%checkout =price quantity=@ud]
  ==
--
