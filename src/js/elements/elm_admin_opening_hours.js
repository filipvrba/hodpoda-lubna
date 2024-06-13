import ElmAlert from "./elm_alert";

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
    );

    window.aohSaveClick = this.saveClick.bind(this)
  };

  connectedCallback() {
    return null
  };

  disconnectedCallback() {
    return null
  };

  saveClick() {
    let lDayValues = day => (
      [
        document.getElementById(`${day}_od`).value,
        document.getElementById(`${day}_do`).value
      ]
    );

    let days = [];

    for (let day of "pondeli utery streda ctvrtek patek sobota nedele".split(" ")) {
      let times = lDayValues(day);
      days.push(times[0].length === 0 || times[1].length === 0 ? "" : times.join("-"))
    };

    return _BefDb.set(
      `UPDATE opening_hours SET monday = '${days[0]}', tuesday = '${days[1]}', wednesday = '${days[2]}', thursday = '${days[3]}', friday = '${days[4]}', saturday = '${days[5]}', sunday = '${days[6]}' WHERE user_id = 1;`,

      (isSave) => {
        if (isSave) {
          return Events.emit(
            "#app",
            ElmAlert.ENVS.SHOW,
            {endTime: 7, message: "Otevírací doba byla úspěšně uložena."}
          )
        }
      }
    )
  };

  initElm(data) {
    let template = `${`
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
<div class='text-center'>
  <button class='btn btn-warning' onclick='aohSaveClick()'>Uložit</button>
</div>
    `}`;
    return this.innerHTML = template
  }
}