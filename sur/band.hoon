::::
::  band (stripe integration)
::
::  hoon structures for stripe api integration
::
::
|%
+$  api-key  @t
+$  price    @ud                                        ::  price in cents
+$  url      @t
+$  update
  $%  [%checkout =price quantity=@ud]
      [%stripe-auth =api-key]
  ==
+$  action
  $%  [%checkout =price quantity=@ud]
  ==
--
