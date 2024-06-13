export default class ElmAdminDashboard extends HTMLElement {
  constructor() {
    super();
    this._hTick = e => update(e.detail.value);
    this.initElm();
    window.adminDashboardBtnClick = this.buttonClick.bind(this)
  };

  connectedCallback() {
    return null
  };

  disconnectedCallback() {
    return null
  };

  buttonClick(index) {
    return URLParams.set(ElmAdminDashboard.PARAMETER, index)
  };

  activeNavs(index) {
    let paramIndex = URLParams.getIndex(ElmAdminDashboard.PARAMETER);

    if (index === paramIndex) {
      return {nav: "active", content: "active show"}
    } else {
      return {nav: "", content: ""}
    }
  };

  initElm() {
    let openingHoursClass = this.activeNavs(0);
    let profileClass = this.activeNavs(1);
    let template = `${`
<div class='col-md-8 mx-auto'>
  <elm-alert></elm-alert>

  <nav>
    <div class='nav nav-tabs mb-3 justify-content-center' id='nav-tab' role='tablist'>
      <button class='nav-link ${openingHoursClass.nav}' onclick='adminDashboardBtnClick(0)' id='nav-opening-hours-tab' data-bs-toggle='tab' data-bs-target='#nav-opening-hours' type='button' role='tab' aria-controls='nav-opening-hours' aria-selected='false' tabindex='-1'>Otevírací doba</button>
      <button class='nav-link ${profileClass.nav}' onclick='adminDashboardBtnClick(1)' id='nav-profile-tab' data-bs-toggle='tab' data-bs-target='#nav-profile' type='button' role='tab' aria-controls='nav-profile' aria-selected='false' tabindex='-1'>Profil</button>

    </div>
  </nav>
  <div class='tab-content' id='nav-tabContent'>
    <div class='tab-pane fade ${openingHoursClass.content} col-lg-8 mx-auto' id='nav-opening-hours' role='tabpanel' aria-labelledby='nav-opening-hours-tab'>
      <elm-admin-opening-hours></elm-admin-opening-hours>
    </div>
    <div class='tab-pane fade ${profileClass.content} col-lg-8 mx-auto' id='nav-profile' role='tabpanel' aria-labelledby='nav-profile-tab'>
      <elm-admin-profile></elm-admin-profile>
    </div>
  </div>
</div>
    `}`;
    return this.innerHTML = template
  }
};

ElmAdminDashboard.PARAMETER = "admin-index"