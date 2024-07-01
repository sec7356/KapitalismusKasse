//Autor: @Selim

"use strict";

//Google Captcha Codes:
//client code: 6LezhuwpAAAAAIeLzgoFKHqHqLqkTqgEqpj33xBN
//server & recaptcha code: 6LezhuwpAAAAANZ_H6ftfZV8d3pd5wbp3psrNB07


window.addEventListener('load', () => {
    	  const $recaptcha = document.querySelector('#g-recaptcha-response');
    	  if ($recaptcha) {
    	    $recaptcha.setAttribute('required', 'required');
    	  }
    	})
