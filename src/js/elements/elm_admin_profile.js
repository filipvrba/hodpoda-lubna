import CryptoJS from "crypto-js";
import ElmAlert from "./elm_alert";

export default class ElmAdminProfile extends HTMLElement {
  constructor() {
    super();
    this.initElm();
    this._adminInputPasswordNew = document.getElementById("adminPasswordNew");
    this._adminBtnSavePassword = document.getElementById("adminBtnSavePassword");
    this._adminInputPasswordNewRepeat = document.getElementById("adminPasswordNewRepeat");
    window.adminBtnSavePassword = this.adminBtnSavePassword.bind(this);
    window.adminPasswordNewInputChange = this.adminPasswordNewInputChange.bind(this);
    window.adminPasswordNewRepeatInputChange = this.adminPasswordNewRepeatInputChange.bind(this);
    this.adminPasswordNewInputChange()
  };

  connectedCallback() {
    return null
  };

  disconnectedCallback() {
    return null
  };

  initElm() {
    let template = `${`
<div id='adminPasswordForm' class='text-center'>
  <h2>Heslo</h2>
  <p>Změna na nové heslo.</p>

  <input type='password' class='form-control' id='adminPasswordNew' oninput='adminPasswordNewInputChange()' placeholder='Zadejte nové heslo' aria-describedby='validationAdminPasswordFeedback' required>
  <div id='validationAdminPasswordFeedback' class='invalid-feedback'>
    Při přihlášení jste zadali špatné heslo!
  </div>
  <br>
  <input type='password' class='form-control' id='adminPasswordNewRepeat' oninput='adminPasswordNewRepeatInputChange()' placeholder='Zadejte znovu nové heslo' aria-describedby='validationAdminPasswordFeedback' required>
  <div id='validationAdminPasswordFeedback' class='invalid-feedback'>
    Heslo se neshoduje s tím, které bylo vyplněno jako první.
  </div>

  <button class='btn btn-warning mt-3 mb-5' id='adminBtnSavePassword' onclick='adminBtnSavePassword()'>Uložit</button>
</div>
    `}`;
    return this.innerHTML = template
  };

  adminPasswordNewInputChange() {
    return this._adminBtnSavePassword.disabled = this._adminInputPasswordNew.value.length === 0 || this._adminInputPasswordNewRepeat.value.length === 0
  };

  adminBtnSavePassword() {
    return this._adminInputPasswordNewRepeat.value === this._adminInputPasswordNew.value ? this.btnSuccessSavePassword(this._adminInputPasswordNew.value) : this._adminInputPasswordNewRepeat.classList.add("is-invalid")
  };

  adminPasswordNewRepeatInputChange() {
    this.adminPasswordNewInputChange();

    if (this._adminInputPasswordNewRepeat.classList.contains("is-invalid")) {
      return this._adminInputPasswordNewRepeat.classList.remove("is-invalid")
    }
  };

  btnSuccessSavePassword(newPassword) {
    let hashedPassword = CryptoJS.MD5(newPassword).toString();

    return _BefDb.set(
      `UPDATE users SET password_hash = '${hashedPassword}' WHERE id = 1 AND is_admin=1;`,

      (isSave) => {
        if (isSave) {
          this._adminInputPasswordNew.value = "";
          this._adminInputPasswordNewRepeat.value = "";
          this.adminPasswordNewInputChange();

          return Events.emit(
            "#app",
            ElmAlert.ENVS.SHOW,
            {endTime: 7, message: "Profil byl úspěšně uložen."}
          )
        }
      }
    )
  }
}