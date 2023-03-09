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
    =^  cards  agent  (on-poke:ag mar vaz)
    :_  this
    ?+  mar  ~
    ::
        %handle-http-request
      ^-  (list card)
      =/  req  !<((pair @ta inbound-request:eyre) vaz)
      =/  url  url.request.q.req
      =/  last-customer  '0'
      =/  customer-hash  (hmac-sha256t:hmac:crypto salt.this last-customer)
      =/  hash-length  (met 3 customer-hash)
      :: ~
      :: |^  use helper arms
      ?+    method.request.q.req  ~
          %'GET'
        ?:  =((cut 3 [0 8] url) '/success')
          =/  req-hash  (cut 3 [9 (met 3 url)] url)
          =/  frnt
            %-  as-octs:mimes:html
            %-  crip
                "<!DOCTYPE html><html><head><title>%band</title></head><body><center><section><div class='product'><img src='https://nyc3.digitaloceanspaces.com/mastyr-bottec/mastyr-bottec/2023.3.06..15.15.38-all-over-print-reversible-bucket-hat-white-front-outside-64050afb5a4ed.jpg' width='500' alt='Based Combo Pack'><div class='description'><h1>Great Success!</h1><h3>YOUR PLANET</h3><h3 style='color:red'>WARNING: DO NOT REFRESH WITHOUT TAKING YOUR PLANET!!!</h3><h4>Your hat will be delivered via email (correspondence)</h4></div></div></section></center></body></html>"
          :~  [%give %fact [/http-response/[p.req]]~ %http-response-header !>([200 ~])]
              [%give %fact [/http-response/[p.req]]~ %http-response-data !>(`frnt)]
              [%give %kick [/http-response/[p.req]]~ ~]
          ==  ::  cards
        ~
      ::
          %'POST'
        ?>  =(url '/checkout')
        ~&  [%checkout req]
        =/  customer-id  '1'  ::  adslkfj
        ::  get the customer-id out of the hidden form input field
        :~  :*  %pass
                /checkout/[p.req]/[last-customer]
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
                    :~  "success_url=http://localhost/{(trip app)}/_band/success/{(trip customer-id)}/{(trip customer-hash)}"
                        "cancel_url=http://localhost/{(trip app)}/_band/cancel"
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
    :~  [%pass /bind-cancel %arvo %e %connect `/'apps'/[app]/'_band'/'cancel' app]
        [%pass /bind-success %arvo %e %connect `/'apps'/[app]/'_band'/'success' app]
        [%pass /bind-checkout %arvo %e %connect `/'apps'/[app]/'_band'/'checkout' app]
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
    =^  cards  agent  (on-arvo:ag wir sig)
    [cards this]
  ::
  ++  on-fail
    |=  [=term =tang]
    ^-  (quip card agent:gall)
    =^  cards  agent  (on-fail:ag term tang)
    [cards this]
  --
--
