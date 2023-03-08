/-  *band
/+  verb, dbug, default-agent, product
::
|%
::
+$  versioned-state  $%(state-0)
::
::  we give each "buy now" button pusher on /band an @ id and pass 
::  it into the success url redirect for stripe to use after 
::  checkout so we can associate the customer with the stripe 
::  payment intent id we get back from the post to 
::  /v1/checkout/sessions
+$  state-0  
  $:  %0 
      =api-key
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
  :~  [%pass /bind-band %arvo %e %connect `/'band' %band]
      [%pass /bind-cancel %arvo %e %connect `/'cancel' %band]
      [%pass /bind-success %arvo %e %connect `/'success' %band]
      [%pass /bind-create-checkout-session %arvo %e %connect `/'create-checkout-session' %band]
      [%pass /bind-get-payment-status %arvo %e %connect `/'get-payment-status' %band]
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
    :: TODO assert self
    =/  planet-invites  !<  (list @t)  vaz
    [~ this(planet-invites planet-invites)]
  ::
      %handle-http-request
    =/  req  !<((pair @ta inbound-request:eyre) vaz)
    =/  url  url.request.q.req
    ?+    method.request.q.req  `this
        %'GET'
      ?:  =((cut 3 [0 8] url.request.q.req) '/success')
      =/  customer  (cut 3 [9 (met 3 url)] url)
      ::  do something with customer, change the cards
      :_  this(customers (~(del by customers) (slav %ud customer)))
      :~  :*  %pass
              /get-payment-status/[p.req]/[customer]
              %arvo
              %i
              %request
              :*  %'GET'
                  %^  cat  3
                      'https://api.stripe.com/v1/payment_intents/'
                      (~(got by customers) (slav %ud customer))
                  :~  :-  'Authorization' 
                          'Bearer sk_test_51Ju6bbJe5Jimk9FCEWEbimwgBoBEQqNlpmE383OLuFmkaFAoHl01pS1ro3i1Wu8yMpibpCB0UhsdQuKNOj2s1NQl00Rx7YkoaB'
                      :-  'Accept'
                          'application/json'
                  == ::  headers
                  ~
              == ::  GET request
              *outbound-config:iris
          == ::  card
      ==  ::  cards
      ::
      ?:  =(url '/cancel')
        =/  frnt  %-  as-octs:mimes:html
                      '<!DOCTYPE html><html><head><title>%band</title></head><center><body><section><div class="product"><img src="http://www.staples-3p.com/s7/is/image/Staples/s0709582_sc7?$splssku$" alt="An ordinary rubber band."><div class="description"><h1 style="color:red">No pay? :(</h1><h1>Enjoy rubber band!</h1></div></div></section></body></center></html>'
        :_  this
        :~  [%give %fact [/http-response/[p.req]]~ %http-response-header !>([200 ~])]
            [%give %fact [/http-response/[p.req]]~ %http-response-data !>(`frnt)]
            [%give %kick [/http-response/[p.req]]~ ~]
        ==  ::  cards
      ?.  =(url.request.q.req '/band')  !!
      =/  left  (scow %ud (lent planet-invites.this))
      =/  products  (list product)
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
                    ;img@"https://nyc3.digitaloceanspaces.com/mastyr-bottec/mastyr-bottec/2023.3.06..15.15.38-all-over-print-reversible-bucket-hat-white-front-outside-64050afb5a4ed.jpg"(alt "Limited Edition Galaxy Brain Bucket Hat", width "350");
                    ;div(class "description")
                      ;h3(style "color: red;"): "YOURS NOW FOR ONLY $64.00"
                    ==
                    ;form(action "/create-checkout-session", method "POST")
                      ;button(type "submit", id "checkout-button"): "Buy Now"
                    ==
                  ==
                ==
              ==
            ==
          ==
::
      :_  this
      :~  [%give %fact [/http-response/[p.req]]~ %http-response-header !>([200 ~])]
          [%give %fact [/http-response/[p.req]]~ %http-response-data !>(`frnt)]
          [%give %kick [/http-response/[p.req]]~ ~]
      ==  ::  cards
        %'POST'
      ::  construct a card to send to iris
      :_  this(last-customer +(last-customer))
      :~  :*  %pass
              /create-checkout-session/[p.req]/[(scot %ud last-customer)]
              %arvo
              %i
              %request
              :*  %'POST' 
                  'https://api.stripe.com/v1/checkout/sessions' 
                  :~  :-  'Content-Type' 
                          'application/x-www-form-urlencoded'
                      :-  'Authorization' 
                          'Bearer sk_test_51Ju6bbJe5Jimk9FCEWEbimwgBoBEQqNlpmE383OLuFmkaFAoHl01pS1ro3i1Wu8yMpibpCB0UhsdQuKNOj2s1NQl00Rx7YkoaB'
                      :-  'Accept'
                          'application/json'
                  ==  ::  headers
                  :-  ~
                  %-  as-octs:mimes:html 
                  %-  crip
                  %-  zing
                  %+  join  "&"
                  ^-  (list tape)
                  :~  "success_url=http://localhost/success/{(scow %ud last-customer.this)}"
                      "cancel_url=http://localhost/cancel"
                      "line_items[0][price]=price_1Mh0YqJe5Jimk9FC1Eo2Opuv"
                      "line_items[0][quantity]=1"
                      "mode=payment"
                  ==  ::  url continuation
              ==  ::  POST request
          *outbound-config:iris
          ==  ::  card
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
      [%bind-cancel ~]
    [~ this]
    ::
      [%bind-create-checkout-session ~]
    [~ this]
    ::
      [%bind-success ~]
    [~ this]
    ::
      [%bind-get-payment-status ~]
    [~ this]
    ::
      [%get-payment-status @ @ ~]
    ?>  ?=([%iris %http-response %finished * ~ *] sig)
    =/  res=json  (need (de-json:html q.data.u.full-file.client-response.sig))
    ::  TODO JSON reparser
    ?>  ?=(%o -.res)
    =/  status  (~(got by p.res) 'status')
    ?>  ?=(%s -.status)
    ?.  =(p.status 'succeeded')
      :_  this
      :~  [%give %fact [/http-response/[&2.wir]]~ %http-response-header !>([403 ~])]
          [%give %fact [/http-response/[&2.wir]]~ %http-response-data !>(~)]
          [%give %kick [/http-response/[&2.wir]]~ ~]
      ==  ::  cards
    ?~  planet-invites  !!
    =/  planet-invite  (trip i.planet-invites)
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
                ;div.product
                  ;img@"https://i.imgur.com/H3cdoh4.jpg"(width "500", alt "Based Combo Pack");
                  ;div.description
                    ;h1: Great Success!
                    ;a/"{planet-invite}": YOUR PLANET
                    ;h3(style "color: red;"): WARNING DO NOT REFRESH WITHOUT TAKING YOUR PLANET
                    ;h4: Your hat will be delivered via email (correspondence)
                  ==
                ==
              ==
            ==
          ==
        ==
    :_  this(planet-invites t.planet-invites)
    :~  [%give %fact [/http-response/[&2.wir]]~ %http-response-header !>([200 ~])]
        [%give %fact [/http-response/[&2.wir]]~ %http-response-data !>(`frnt)]
        [%give %kick [/http-response/[&2.wir]]~ ~]
    ==  ::  cards
    ::
      [%create-checkout-session @ @ ~]  ::  /create-checkout-session/[+.req]
    ?>  ?=([%iris %http-response %finished * ~ *] sig)
    =/  res=json  (need (de-json:html q.data.u.full-file.client-response.sig))
    ?>  ?=(%o -.res)
    =/  redirect-url  (~(got by p.res) %url)
    ?>  ?=(%s -.redirect-url)
    =/  payment-intent  (~(got by p.res) %'payment_intent')
    ?>  ?=(%s -.payment-intent)
    =/  =response-header:http
      ^-  response-header:http
      :-  303
          ['Location' p.redirect-url]~
    :_  this(customers (~(put by customers) (slav %ud &3.wir) +.payment-intent))
    :~  [%give %fact [/http-response/[&2.wir]]~ %http-response-header !>(response-header)]
        [%give %fact [/http-response/[&2.wir]]~ %http-response-data !>(~)]
        [%give %kick [/http-response/[&2.wir]]~ ~]
    ==  ::  cards
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
