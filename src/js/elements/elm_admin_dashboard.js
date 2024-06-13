export default class ElmAdminDashboard extends HTMLElement {
  constructor() {
    super();
    this._hTick = e => this.update(e.detail.value);
    this.initElm()
  };

  connectedCallback() {
    return null
  };

  disconnectedCallback() {
    return null
  };

  update(dt) {
    return null
  };

  initElm() {
    let template = `${`
<div class='col-md-8 mx-auto'>
  <elm-alert></elm-alert>

  <nav>
    <div class='nav nav-tabs mb-3 justify-content-center' id='nav-tab' role='tablist'>
      <button class='nav-link active' id='nav-opening-hours-tab' data-bs-toggle='tab' data-bs-target='#nav-opening-hours' type='button' role='tab' aria-controls='nav-opening-hours' aria-selected='false' tabindex='-1'>Otevírací doba</button>
    </div>
  </nav>
  <div class='tab-content' id='nav-tabContent'>
    <elm-admin-opening-hours></elm-admin-opening-hours>
  </div>
</div>
    `}`;
    return this.innerHTML = template
  }
}