import ElmAdminLogin from "./elm_admin_login";

export default class ElmAdmin extends HTMLElement {
  constructor() {
    super();
    this._hAdminLogin = e => this.adminLogin(e.detail.value);
    this.initElm()
  };

  connectedCallback() {
    return Events.connect(
      "#app",
      ElmAdminLogin.ENVS.login,
      this._hAdminLogin
    )
  };

  disconnectedCallback() {
    return Events.disconnect(
      "#app",
      ElmAdminLogin.ENVS.login,
      this._hAdminLogin
    )
  };

  adminLogin(isCorrect) {
    if (!isCorrect) {
      Events.emit("#app", ElmAdminLogin.ENVS.validation, isCorrect);
      return
    };

    return this.innerHTML = "<elm-admin-dashboard></elm-admin-dashboard>"
  };

  initElm() {
    let template = `${`\n    <elm-admin-login></elm-admin-login>\n    `}`;
    return this.innerHTML = template
  }
}