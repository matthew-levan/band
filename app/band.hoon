::
::  ~palfun-foslup recommends writing a wrapper library
::  that wraps a client agent and runs as an agent
::
/-  *band
/+  verb, dbug, band, default-agent
::
|%
::
+$  versioned-state  $%(state-0)
::
+$  state-0  
  $:  %0 
      =customers
      last-customer=customer
      planet-invites=(list @t)
  ==
::
::  boilerplate
::
+$  card  card:agent:gall
--
::
%+  verb  &
%-  agent:dbug
%+  agent:band  :+
  'sk_test_51Ju6bbJe5Jimk9FCEWEbimwgBoBEQqNlpmE383OLuFmkaFAoHl01pS1ro3i1Wu8yMpibpCB0UhsdQuKNOj2s1NQl00Rx7YkoaB'
  'band'
  'price_1Mh0YqJe5Jimk9FC1Eo2Opuv'
=|  state-0
=*  state  -
::
^-  agent:gall
::
=<
|_  =bowl:gall
+*  this  .
    def   ~(. (default-agent this %|) bowl)
    eng   ~(. +> [bowl ~])
++  on-init
  ^-  (quip card _this)
  :_  this
  :~  [%pass /bind-band %arvo %e %connect `/apps/band %band]
  ==
::
++  on-save
  ^-  vase
  !>(state)
::
++  on-load
  |=  ole=vase
  ^-  (quip card _this)
  =^  cards  state
    abet:(load:eng ole)
  [cards this]
::
++  on-poke
  |=  [mar=mark vaz=vase]
  ^-  (quip card _this)
  ?+    mar  (on-poke:def [mar vaz])
  ::
      %handle-http-request
    =/  req  !<((pair @ta inbound-request:eyre) vaz)
    =/  url  url.request.q.req
    ?+    method.request.q.req  `this
      %'GET'
    ?.  =(url '/apps/band')  !!
    =/  frnt  
      %-  as-octs:mimes:html
      %-  crip
      %-  en-xml:html
        ;html
          ;head
            ;title: %band
          ==
          ;body
            ;center
              ;section
                ;div(class "product")
                  ;img@"https://nyc3.digitaloceanspaces.com/mastyr-bottec/mastyr-bottec/2023.3.06..15.15.38-all-over-print-reversible-bucket-hat-white-front-outside-64050afb5a4ed.jpg"(width "350", alt "Bucket Hat");
                  ;div(class "description")
                    ;p(style "color: grey;"): Available now until the end of Volcano Summit
                    ;h1: Galaxy Brain Bucket Hat
                    ;span(class "blink")
                      ;h1(style "color: green;"): $64.00
                    ==  ::  span
                  ==  ::  div description
                  ;form(action "/apps/band/_band/checkout", method "POST")
                    ;input(type "hidden", id "customer-id", name "customer-id", value (trip last-customer.this))
                    ;button(type "submit", id "checkout-button"): Buy Now
                  ==  ::  form
                ==  ::  div product
              ==  ::  section
            ==  ::  center
          ==  ::  body
        ==  ::  html
      ==  ::  ???
    :_  this
    :~  [%give %fact [/http-response/[p.req]]~ %http-response-header !>([200 ~])]
        [%give %fact [/http-response/[p.req]]~ %http-response-data !>(`frnt)]
        [%give %kick [/http-response/[p.req]]~ ~]
      ==  ::  cards
    ==  ::  method
  ==  ::  mark
::
++  on-peek   on-peek:def
::
++  on-agent  on-agent:def
::
++  on-arvo
  |=  [wir=wire sig=sign-arvo]
  ^-  (quip card _this)
  ?+    wir  (on-arvo:def wir sig)
      [%bind-band ~]
    [~ this]
  ==  ::  wire
::
++  on-watch
  |=  =path
  ^-  (quip card _this)
  ?+    path  (on-watch:def path)
      [%http-response *]
    %-  (slog leaf+"Eyre subscribed to {(spud path)}." ~)
    [~ this]
  ==  ::  path
::
++  on-fail   on-fail:def
++  on-leave  on-leave:def
--
::
|_  [bol=bowl:gall dek=(list card)]
+*  dat  .
++  emit  |=(=card dat(dek [card dek]))
++  emil  |=(lac=(list card) dat(dek (welp lac dek)))
++  abet
  ^-  (quip card _state)
  [(flop dek) state]
::
++  init
  ^+  dat
  dat
::
++  load
  |=  vaz=vase
  ^+  dat
  ?>  ?=([%0 *] q.vaz)
  dat(state !<(state-0 vaz))
--
