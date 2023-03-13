::  band: agent wrapper for generic payments
::
::    usage: %-(agent:band your-agent)
::
/-  *band
|%
+$  state-0  
  $:  %0 
      salt=@uvJ
  ==
+$  poke
  $%  [%bowl ~]
      [%state grab=cord]
  ==
+$  card
  $+  card  card:agent:gall
::
++  agent
  |=  [[=api-key app=@t =price-id] =agent:gall]
  =|  state-0
  =*  state  -
  ^-  agent:gall
  |_  =bowl:gall
  +*  this  .
      ag    ~(. agent bowl)
  ::
  ++  on-poke
    |=  [mar=mark vaz=vase]
    ^-  (quip card _this)
    :_  this
    ?+  mar  ~
    ::
        %handle-http-request
      ^-  (list card)
      =/  req  !<((pair @ta inbound-request:eyre) vaz)
      =/  url  url.request.q.req
      ~&  url
      =/  last-customer  '0'
      =/  customer-hash  (hmac-sha256t:hmac:crypto salt.this last-customer)
      =/  hash-length  (met 3 customer-hash)
      =/  app-length  (met 3 app)
      ::  ~
      ?+    method.request.q.req
        =^  cards  agent  (on-poke:ag mar vaz)  cards
          %'GET'
        ?:  =(url (crip "/apps/{(trip app)}/_band/cancel"))
          =/  frnt
          %-  as-octs:mimes:html
          %-  crip
          %-  en-xml:html
          ;html
            ;head
              ;title: [app]
            ==
            ;body
              ;center
                ;h1: Sorry to see you go.
              ==  ::  center
            ==  ::  body
          ==  ::  html
          :~  [%give %fact [/http-response/[p.req]]~ %http-response-header !>([200 ~])]
              [%give %fact [/http-response/[p.req]]~ %http-response-data !>(`frnt)]
              [%give %kick [/http-response/[p.req]]~ ~]
          ==  ::  cards
        ?:  =((cut 3 [0 (add app-length 20)] url) (crip "/apps/{(trip app)}/_band/success"))
          ~&  %.y
          =/  req-hash  (cut 3 [9 (met 3 url)] url)
          =/  frnt
          %-  as-octs:mimes:html
          %-  crip
          %-  en-xml:html
          ;html
            ;head
              ;title: [app]
            ==  ::  head
            ;body
              ;center
                ;h1: Success!
              ==  ::  center
            ==  ::  body
          ==  ::  html
          :~  [%give %fact [/http-response/[p.req]]~ %http-response-header !>([200 ~])]
              [%give %fact [/http-response/[p.req]]~ %http-response-data !>(`frnt)]
              [%give %kick [/http-response/[p.req]]~ ~]
          ==  ::  cards
        =^  cards  agent  (on-poke:ag mar vaz)  cards
      ::
          %'POST'
        ?.  =(url (crip "/apps/{(trip app)}/_band/checkout"))
          =^  cards  agent  (on-poke:ag mar vaz)  cards
        =/  customer-id  '1'  ::  adslkfj
        =/  pref  "http://localhost/{(trip app)}/_band"
        =/  succ  "{pref}/success/{(trip customer-id)}/{(trip customer-hash)}"
        =/  cncl  "{pref}/cancel"
        ::  get the customer-id out of the hidden form input field
        :~  :*  %pass
                /apps/[app]/'_band'/'checkout'/[p.req]/[customer-id]/[customer-hash]
                %arvo
                %i
                %request
                :*  %'POST' 
                    'https://api.stripe.com/v1/checkout/sessions' 
                    :~  :-  'Content-Type' 
                            'application/x-www-form-urlencoded'
                        :-  'Authorization' 
                            (crip "Bearer {(trip api-key)}")
                        :-  'Accept'
                            'application/json'
                    ==  ::  headers
                    :-  ~
                    %-  as-octs:mimes:html 
                    %-  crip
                    %-  zing
                    %+  join  "&"
                    ^-  (list tape)
                    :~  "success_url={succ}"
                        "cancel_url={cncl}"
                        "line_items[0][price]={(trip price-id)}"
                        "line_items[0][quantity]=1"
                        "mode=payment"
                    ==  ::  body
                ==  ::  request
                *outbound-config:iris
            ==  ::  iris card
        ==  ::  list of cards
      ==
    ==
  ::
  ++  on-peek
    |=  =path
    ^-  (unit (unit cage))
    ?.  ?=([@ %band *] path)
      (on-peek:ag path)
    ?+  path  [~ ~]
      [%u %band ~]  ``noun+!>(&)
    ==
  ::
  ++  on-init
    ^-  (quip card agent:gall)
    =^  cards  agent  on-init:ag
    =.  cards  %+  weld  cards
    ^-  (list card)
    :~  [%pass /'apps'/[app]/'_band'/'bind-cancel' %arvo %e %connect `/'apps'/[app]/'_band'/'cancel' app]
        [%pass /'apps'/[app]/'_band'/'bind-checkout' %arvo %e %connect `/'apps'/[app]/'_band'/'checkout' app]
        [%pass /'apps'/[app]/'_band'/'bind-success' %arvo %e %connect `/'apps'/[app]/'_band'/'success' app]
    ==
    [cards this(salt eny.bowl)]
  ::
  ++  on-save   on-save:ag
  ::
  ++  on-load
    |=  old-state=vase
    ^-  (quip card agent:gall)
    =^  cards  agent  (on-load:ag old-state)
    [cards this]
  ::
  ++  on-watch
    |=  =path
    ^-  (quip card agent:gall)
    =^  cards  agent  (on-watch:ag path)
    ?+    path  (on-watch:ag path)
        [%http-response *]
      %-  (slog leaf+"Eyre subscribed to {(spud path)}." ~)
      `this
    ==
  ::
  ++  on-leave
    |=  =path
    ^-  (quip card agent:gall)
    =^  cards  agent  (on-leave:ag path)
    [cards this]
  ::
  ++  on-agent
    |=  [=wire =sign:agent:gall]
    ^-  (quip card agent:gall)
    =^  cards  agent  (on-agent:ag wire sign)
    [cards this]
  ::
  ++  on-arvo
    |=  [wir=wire sig=sign-arvo]
    ^-  (quip card agent:gall)
    :_  this
    ?:  =(wir /'apps'/[app]/'_band'/'cancel')
      ~
    ?:  =(wir /'apps'/[app]/'_band'/'success')
      ~
    ?:  =(wir /'apps'/[app]/'_band'/'checkout')
      ?>  ?=([%iris %http-response %finished * ~ *] sig)
      =/  res=json  (need (de-json:html q.data.u.full-file.client-response.sig))
      ?>  ?=(%o -.res)
      =/  redirect-url  (~(got by p.res) %url)
      ?>  ?=(%s -.redirect-url)
      =/  =response-header:http
        ^-  response-header:http
        :-  303
            ['Location' p.redirect-url]~
      :~  [%give %fact [/http-response/[&2.wir]]~ %http-response-header !>(response-header)]
          [%give %fact [/http-response/[&2.wir]]~ %http-response-data !>(~)]
          [%give %kick [/http-response/[&2.wir]]~ ~]
      ==
    =^  cards  agent  (on-arvo:ag wir sig)  cards
  ::
  ++  on-fail
    |=  [=term =tang]
    ^-  (quip card agent:gall)
    =^  cards  agent  (on-fail:ag term tang)
    [cards this]
  --
--
