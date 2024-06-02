import openingHoursObj from "../../json/opening_hours.json";

export default class ElmOpeningHours extends HTMLElement {
  constructor() {
    super();
    this.initElm()
  };

  get openingHours() {
    return openingHoursObj.month.march
  };

  initElm() {
    let template = `${`
<section class='mb-4 text-center'>
  <h2>Otevírací Doba</h2>
  <ul class='list-group'>
    ${this.subinitElm()}
  </ul>
</section>
    `}`;
    return this.innerHTML = template
  };

  subinitElm() {
    let domDays = [];

    for (let values of this.openingHours.days) {
      let template = `${`\n<li class='list-group-item'><strong>${values.day}:</strong> ${values.clock.from} - ${values.clock.to} hod.</li>\n      `}`;
      domDays.push(template)
    };

    return domDays.join("")
  }
}