import openingHoursObj from "../../json/opening_hours.json";

export default class ElmOpeningHours extends HTMLElement {
  constructor() {
    super();
    this.initElm();

    _BefDb.get(
      "SELECT monday, tuesday, wednesday, thursday, friday, saturday, sunday FROM opening_hours; WHERE user_id=1",

      (rows) => {
        let week = Object.values(rows[0]).map(item => item ? item.split("-") : null);
        return this.initElm(week)
      }
    )
  };

  initElm(value=null) {
    let template = `${`
<section class='mb-4 text-center'>
  <h2>Otevírací Doba</h2>
  <elm-spinner class='mt-5 mb-5'></elm-spinner>
</section>
    `}`;

    if (value) {
      template = `${`
<section class='mb-4 text-center'>
  <h2>Otevírací Doba</h2>
  <ul class='list-group'>
    ${this.subinitElm(value)}
  </ul>
</section>
      `}`
    };

    return this.innerHTML = template
  };

  subinitElm(week) {
    let domDays = [];

    for (let i = 0; i < week.length; i++) {
      if (!week[i]) continue;
      let template = `${`\n<li class='list-group-item'><strong>${ElmOpeningHours.DAYS[i]}:</strong> ${week[i][0]} - ${week[i][1]} hod.</li>\n      `}`;
      domDays.push(template)
    };

    return domDays.join("")
  }
};

ElmOpeningHours.DAYS = [
  "Pondělí",
  "Úterý",
  "Středa",
  "Čtvrtek",
  "Pátek",
  "Sobota",
  "Neděle"
]