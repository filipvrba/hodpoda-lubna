import { ENV } from "../env";

export default class Net {
  static curl(url, callback) {
    return fetch(url).then(response => response.text()).then((text) => {
      if (callback) return callback(text)
    })
  };

  static befJson(url, callback) {
    return fetch(url).then(response => response.json()).then((data) => {
      if (data.statusCode) {
        console.error(`GET: ${data.statusCode} ${data.status}`);
        if (callback) return callback([])
      } else if (callback) {
        return callback(data)
      }
    })
  };

  static befSend(method, query, callback) {
    method = method.toUpperCase();

    return fetch(ENV.VITE_URL_API, {method, headers: {
      Token: ENV.VITE_BEF_SERVER,
      Database: ENV.VITE_DATABASE,
      Query: query
    }}).then(response => response.json()).then((data) => {
      if (data.statusCode === 403 || data.statusCode === 405 || data.status === Net.SQL_ERR) {
        console.error(`${method}: ${data.statusCode} ${data.status}`);
        if (callback) return callback(false)
      } else if (callback) {
        return callback(true)
      }
    })
  }
};

Net.SQL_ERR = "SQL Error";
window.Net = Net