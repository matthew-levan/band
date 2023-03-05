  ::  band (stripe integration)
::::
::    hoon structures for stripe api integration
::
|%
+$  api-key         @t                                  ::  Stripe API (careful)
+$  price           @ud                                 ::  price in cents
+$  customer        @
+$  payment-intent  @t
+$  customers       (map customer payment-intent)
+$  update
  $%  [%checkout =price quantity=@ud]
      [%stripe-auth =api-key]
  ==
+$  action
  $%  [%checkout =price quantity=@ud]
  ==
--
