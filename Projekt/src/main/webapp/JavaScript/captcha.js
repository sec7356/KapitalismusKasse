"use strict";

/*
document.addEventListener('DOMContentLoaded', function () {
  const fonts = ["cursive", "sans-serif", "serif", "monospace"];
  let captchaValue = "";
  
  function generateCaptcha() {
    let value = btoa(Math.random() * 1000000000);
    value = value.substr(0, 5 + Math.random() * 5);
    captchaValue = value;
  }
  
  function setCaptcha() {
    let html = captchaValue
      .split("")
      .map((char) => {
        const rotate = -20 + Math.trunc(Math.random() * 30);
        const font = Math.trunc(Math.random() * fonts.length);
        return `<span 
          style="
            transform:rotate(${rotate}deg);
            font-family:${fonts[font]}
          "
        >${char}</span>`;
      })
      .join("");
    document.querySelector(".captcha .preview").innerHTML = html;
  }
  
  function initCaptcha() {
    document.querySelector(".captcha .captcha-refresh")
      .addEventListener("click", function (e) {
        e.preventDefault();  // Verhindert, dass der Button das Formular absendet
        generateCaptcha();
        setCaptcha();
      });
    generateCaptcha();
    setCaptcha();
  }
  
  initCaptcha();
  
  document.querySelector(".register-form button[type='submit']")
    .addEventListener("click", function (e) {
      let inputCaptchaValue = document.querySelector(".captcha input").value;
      if (inputCaptchaValue !== captchaValue) {
        e.preventDefault();  // Verhindert, dass das Formular abgesendet wird
        swal("Ungültiges Captcha", "", "error");
      }
    });
});
*/

//Google Captcha Codes:
//to user 6LezhuwpAAAAAIeLzgoFKHqHqLqkTqgEqpj33xBN
//site and recaptcha 6LezhuwpAAAAANZ_H6ftfZV8d3pd5wbp3psrNB07
//oben code für schrift-captcha, unten für v2 zur überprüfung ob es gemacht wurde



window.addEventListener('load', () => {
    	  const $recaptcha = document.querySelector('#g-recaptcha-response');
    	  if ($recaptcha) {
    	    $recaptcha.setAttribute('required', 'required');
    	  }
    	})
 

 /* alter captcha (mit schrift) code: (in div=captcha rein)
 
 <div class="flex-item">
                <label for="captcha-input">Captcha eingeben</label>
                <div class="preview"></div>
                <div class="captcha-form">
                    <input type="text" class="captcha-input" placeholder="Captcha hier eingeben" required>
                    <button class="captcha-refresh" type="button">
                        <i class="fa fa-refresh">Erneut laden</i>
                    </button>
                </div>
            </div>
            
*/