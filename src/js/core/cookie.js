class Cookie {
  static get(name) {
    let nameEQ = `${name}=`;
    let ca = document.cookie.split(";");

    for (let i = 0; i < ca.length; i++) {
      let c = ca[i];

      while (c.charAt(0) === " ") {
        c = c.substring(1, c.length);
        if (c.indexOf(nameEQ) === 0) return c.substring(nameEQ.length, c.length)
      }
    };

    return null
  };

  static set(name, value, minutes) {
    let expires = "";

    if (minutes) {
      let date = new Date;
      date.setTime(date.getTime() + (minutes * 60 * 1_000));
      expires = "; expires=" + date.toUTCString()
    };

    return document.cookie = name + "=" + (value || "") + expires + "; path=/"
  };

  static erase(name) {
    return document.cookie = name + "=; Max-Age=-99999999;"
  }
};

window.Cookie = Cookie