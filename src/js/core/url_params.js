class URLParams {
  static get(parameter) {
    let url = new URL(window.location.href);
    let urlParams = new URLSearchParams(url.search);
    return urlParams.get(parameter)
  };

  static set(parameter, value) {
    let url = new URL(window.location.href);
    let urlParams = new URLSearchParams(url.search);
    urlParams.set(parameter, value);
    url.search = urlParams.toString();
    return window.history.pushState({}, "", url)
  };

  static getIndex(parameter) {
    let param = URLParams.get(parameter);
    return param === null ? 0 : parseInt(param)
  }
};

window.URLParams = URLParams