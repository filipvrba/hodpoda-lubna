export default class ElmAdminOpeningHours extends HTMLElement {
  constructor() {
    super();
    this.innerHTML = "<elm-spinner class='text-center mt-5 mb-5'></elm-spinner>";

    _BefDb.get(
      "SELECT monday, tuesday, wednesday, thursday, friday, saturday, sunday FROM opening_hours; WHERE user_id=1",

      (rows) => {
        let week = Object.values(rows[0]).map(item => (
          item ? item.split("-") : ["", ""]
        ));

        let data = {openingHours: week};
        return this.initElm(data)
      }
    )
  };

  connectedCallback() {
    return null
  };

  disconnectedCallback() {
    return null
  };

  initElm(data) {
    let template = `${`
<div class='tab-pane fade active show col-lg-8 mx-auto' id='nav-opening-hours' role='tabpanel' aria-labelledby='nav-opening-hours-tab'>
  <table class='table table-bordered'>
    <thead>
      <tr>
        <th>Den</th>
        <th>Od</th>
        <th>Do</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td>Pondělí</td>
        <td><input type='time' class='form-control' name='pondeli_od' id='pondeli_od' value='${data.openingHours[0][0]}'></td>
        <td><input type='time' class='form-control' name='pondeli_do' id='pondeli_do' value='${data.openingHours[0][1]}'></td>
      </tr>
      <tr>
        <td>Úterý</td>
        <td><input type='time' class='form-control' name='utery_od' id='utery_od' value='${data.openingHours[1][0]}'></td>
        <td><input type='time' class='form-control' name='utery_do' id='utery_do' value='${data.openingHours[1][1]}'></td>
      </tr>
      <tr>
        <td>Středa</td>
        <td><input type='time' class='form-control' name='streda_od' id='streda_od' value='${data.openingHours[2][0]}'></td>
        <td><input type='time' class='form-control' name='streda_do' id='streda_do' value='${data.openingHours[2][1]}'></td>
      </tr>
      <tr>
        <td>Čtvrtek</td>
        <td><input type='time' class='form-control' name='ctvrtek_od' id='ctvrtek_od' value='${data.openingHours[3][0]}'></td>
        <td><input type='time' class='form-control' name='ctvrtek_do' id='ctvrtek_do' value='${data.openingHours[3][1]}'></td>
      </tr>
      <tr>
        <td>Pátek</td>
        <td><input type='time' class='form-control' name='patek_od' id='patek_od' value='${data.openingHours[4][0]}'></td>
        <td><input type='time' class='form-control' name='patek_do' id='patek_do' value='${data.openingHours[4][1]}'></td>
      </tr>
      <tr>
        <td>Sobota</td>
        <td><input type='time' class='form-control' name='sobota_od' id='sobota_od' value='${data.openingHours[5][0]}'></td>
        <td><input type='time' class='form-control' name='sobota_do' id='sobota_do' value='${data.openingHours[5][1]}'></td>
      </tr>
      <tr>
        <td>Neděle</td>
        <td><input type='time' class='form-control' name='nedele_od' id='nedele_od' value='${data.openingHours[6][0]}'></td>
        <td><input type='time' class='form-control' name='nedele_do' id='nedele_do' value='${data.openingHours[6][1]}'></td>
      </tr>
    </tbody>
  </table>
</div>
    `}`;
    return this.innerHTML = template
  }
}