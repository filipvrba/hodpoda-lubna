export default class ElmSpinner extends HTMLElement {
  constructor() {
    super();
    this.initElm()
  };

  initElm() {
    let template = `${`
<div class='spinner-border text-primary' role='status'>
  <span class='visually-hidden'>Loading...</span>
</div>
    `}`;
    return this.innerHTML = template
  }
}