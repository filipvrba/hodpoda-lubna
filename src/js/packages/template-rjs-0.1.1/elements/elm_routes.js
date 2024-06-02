export default class ElmRoutes extends HTMLElement {
  constructor() {
    super();

    this._lHashchange = () => {
      return this.changePage()
    };

    this.changePage()
  };

  connectedCallback() {
    return window.addEventListener("hashchange", this._lHashchange)
  };

  disconnectedCallback() {
    return window.removeEventListener("hashchange", this._lHashchange)
  };

  changePage() {
    let currentPage = this.findCurrentPage();
    if (currentPage) return this.initPage(currentPage)
  };

  findCurrentPage() {
    for (let page of ROUTES_JSON.pages) {
      if (page.endpoint !== location.hash.replace("#", "").replaceAll(
        "-",
        "/"
      )) continue;

      return page
    };

    return null
  };

  initPage(page) {
    this.initMeta(page);
    let pageName = page.endpoint.replaceAll("-", "_");
    let content = PAGES[pageName];
    return this.initElm(content, page)
  };

  initElm(content, page=null) {
    let template = `${`\n    ${page ? content.replace(
      "TITLE",
      page.title
    ) : null}\n    `}`;

    return this.innerHTML = template
  };

  // document.query_selector('meta[name="title"]')
  //   .set_attribute('content', title)
  // document.query_selector('meta[property="og:title"]')
  //   .set_attribute('content', title)
  // document.query_selector('meta[property="twitter:title"]')
  //   .set_attribute('content', title)
  // # Description
  // document.query_selector('meta[name="description"]')
  //   .set_attribute('content', page.description)
  // document.query_selector('meta[property="og:description"]')
  //   .set_attribute('content', page.description)
  // document.query_selector('meta[property="twitter:description"]')
  //   .set_attribute('content', page.description)
  // # Image
  // document.query_selector('meta[property="og:image"]')
  //   .set_attribute('content', page.image)
  // document.query_selector('meta[property="twitter:image"]')
  //   .set_attribute('content', page.image)
  // # Url
  // document.query_selector('meta[property="og:url"]')
  //   .set_attribute('content', location.href)
  // document.query_selector('meta[property="twitter:url"]')
  //   .set_attribute('content', location.href)
  initMeta(page) {
    let title = `${page.title} | ${TITLE_APP}`;
    return document.title = title
  }
}