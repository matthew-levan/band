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
  :~  [%pass /bind-band %arvo %e %connect `/'apps'/'band' %band]
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
      %noun
    ::  TODO assert self
    =/  planet-invites  !<  (list @t)  vaz
    [~ this(planet-invites planet-invites)]
  ::
      %handle-http-request
    =/  req  !<((pair @ta inbound-request:eyre) vaz)
    =/  url  url.request.q.req
    ?+    method.request.q.req  `this
      ::
      :: ?:  =(url '/cancel')
      ::   =/  frnt  %-  as-octs:mimes:html
      ::                 '<!DOCTYPE html><html><head><title>%band</title></head><center><body><section><div class="product"><img src="http://www.staples-3p.com/s7/is/image/Staples/s0709582_sc7?$splssku$" alt="An ordinary rubber band."><div class="description"><h1 style="color:red">No pay? :(</h1><h1>Enjoy rubber band!</h1></div></div></section></body></center></html>'
      ::   :_  this
      ::   :~  [%give %fact [/http-response/[p.req]]~ %http-response-header !>([200 ~])]
      ::       [%give %fact [/http-response/[p.req]]~ %http-response-data !>(`frnt)]
      ::       [%give %kick [/http-response/[p.req]]~ ~]
      ::   ==  ::  cards
      %'GET'
      ?.  =(url.request.q.req '/band')  !!
      =/  left  (scow %ud (lent planet-invites.this))
      =/  frnt  
        %-  as-octs:mimes:html
        %-  crip
        %-  en-xml:html
          ;html
            ;head
              ;title: %band
              ;style: ".blink\{animation:blink-animation 1s steps(5,start) infinite;-webkit-animation:blink-animation 1s steps(5,start) infinite}@keyframes blink-animation\{to\{visibility:hidden}}@-webkit-keyframes blink-animation\{to\{visibility:hidden}}"
            ==
            ;body
              ;center
                ;section
                  ;div(class "product")
                    ;img@"https://i.imgur.com/H3cdoh4.jpeg"(width "350", alt "COMBO PACK");
                    ;div(class "description")
                      ;marquee
                        ;h1(style "color: #00f;"): "LIMITED TIME!!! ONLY {left} LEFT!!!"
                      ==  ::  marquee
                      ;p(style "color: grey;"): "Available now until the end of Volcano Summit"
                      ;h1: "Limited Edition Galaxy Brain Bucket Hat"
                      ;h1: "PLUS"
                      ;h1: "FREE L2 PLANET"
                      ;span(class "blink")
                        ;h3(style "color: red;"): "YOURS NOW FOR ONLY $64.00"
                      ==  ::  span
                    ==  ::  div description
                    ;form(action "/checkout", method "POST")
                      ;input(type "hidden", id "customer-id", name "customer-id", value (trip last-customer.this))
                      ;button(type "submit", id "checkout-button"): "Buy Now"
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
    ::
    ::   [%create-checkout-session @ @ ~]  ::  /create-checkout-session/[+.req]
    :: ?>  ?=([%iris %http-response %finished * ~ *] sig)
    :: =/  res=json  (need (de-json:html q.data.u.full-file.client-response.sig))
    :: ?>  ?=(%o -.res)
    :: =/  redirect-url  (~(got by p.res) %url)
    :: ?>  ?=(%s -.redirect-url)
    :: =/  =response-header:http
    ::   ^-  response-header:http
    ::   :-  303
    ::       ['Location' p.redirect-url]~
    :: :_  this(customers (~(put by customers) (slav %ud &3.wir) %.n))
    :: :~  [%give %fact [/http-response/[&2.wir]]~ %http-response-header !>(response-header)]
    ::     [%give %fact [/http-response/[&2.wir]]~ %http-response-data !>(~)]
    ::     [%give %kick [/http-response/[&2.wir]]~ ~]
    :: ==  ::  cards
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
