export default class ElmAdminProfile extends HTMLElement {
  constructor() {
    super();
    this.initElm()
  };

  connectedCallback() {
    return null
  };

  disconnectedCallback() {
    return null
  };

  initElm() {
    let template = `${`\n<p>lol</p>\n    `}`;
    return this.innerHTML = template
  }
}