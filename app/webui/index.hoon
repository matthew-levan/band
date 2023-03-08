^-  manx
;html
  ;head
    ;title = "%band"
    ;style: ".blink\{animation:blink-animation 1s steps(5,start) infinite;-webkit-animation:blink-animation 1s steps(5,start) infinite}@keyframes blink-animation\{to\{visibility:hidden}}@-webkit-keyframes blink-animation\{to\{visibility:hidden}}"
  ==
  ;body
    ;center
      ;section
        ;div(class "product")
          ;img(src "https://i.imgur.com/H3cdoh4.jpeg" width "500" alt "COMBO PACK")
          ;div(class "description")
            ;marquee
            ;h1(style "color: #00f;") = "LIMITED TIME!!! ONLY {left} LEFT!!!"
            ;p(style "color: grey;") = "Available now until the end of Volcano Summit"
            ;h1 = "Limited Edition Galaxy Brain Bucket Hat"
            ;h1 = "PLUS"
            ;h1 = "FREE L2 PLANET"
            ;span(class "blink")
            ;h3(style "color: red;") = "YOURS NOW FOR ONLY $64.00"
          ;form(action "/create-checkout-session" method "POST")
            ;button(type "submit" id "checkout-button") = "Buy Now"
      ==
    ==
  ==
==
