import CryptoJS from "crypto-js";

export default class ElmAdminLogin extends HTMLElement {
  constructor() {
    super();
    this._hAdminValidation = e => this.validationAdminPassword(e.detail.value);
    this.initElm();
    this._inputPasswordDom = document.getElementById("adminPassword");
    window.adminCheckPassword = this.adminCheckPassword.bind(this);
    window.adminPasswordInputChange = this.adminPasswordInputChange.bind(this)
  };

  connectedCallback() {
    return Events.connect(
      "#app",
      ElmAdminLogin.ENVS.validation,
      this._hAdminValidation
    )
  };

  disconnectedCallback() {
    return Events.disconnect(
      "#app",
      ElmAdminLogin.ENVS.validation,
      this._hAdminValidation
    )
  };

  adminCheckPassword() {
    let plainPassword = this._inputPasswordDom.value;
    let hashedPassword = CryptoJS.MD5(plainPassword).toString();
    let correctPassword = "21232f297a57a5a743894a0e4a801fc3";
    let isCorrect = hashedPassword === correctPassword;
    return Events.emit("#app", ElmAdminLogin.ENVS.login, isCorrect)
  };

  adminPasswordInputChange() {
    if (this._inputPasswordDom.classList.contains("is-invalid")) {
      return this.validationAdminPassword(true)
    }
  };

  validationAdminPassword(isValid) {
    return isValid ? this._inputPasswordDom.classList.remove("is-invalid") : this._inputPasswordDom.classList.add("is-invalid")
  };

  initElm() {
    let template = `${`
<div id='adminPasswordForm' class='col-md-6 mx-auto text-center'>
  <input type='password' class='form-control' id='adminPassword' oninput='adminPasswordInputChange()' placeholder='Zadejte heslo' aria-describedby='validationAdminPasswordFeedback' required>
  <div id='validationAdminPasswordFeedback' class='invalid-feedback'>
    Při přihlášení jste zadali špatné heslo!
  </div>

  <button class='btn btn-primary mt-3 mb-5' onclick='adminCheckPassword()'>Přihlásit se</button>
  <div class='alert alert-warning mb-3' role='alert'>
    <em>Pro přístup k administraci tohoto webu je nutné se přihlásit. Po úspěšném přihlášení jako správce budete moci upravovat a spravovat obsah stránky.</em>
  </div>
</div>
    `}`;
    return this.innerHTML = template
  }
};

ElmAdminLogin.ENVS = {login: "al0", validation: "al1"}