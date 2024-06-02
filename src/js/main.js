import "../css/bootstrap.min.css";
import "../css/style.css";
import routesObj from "../json/routes.json";
import "./core";
import "./elements";
import "./pages";
window.ROUTES_JSON = routesObj;
const TITLE_APP = document.title;
window.TITLE_APP = TITLE_APP;
document.querySelector("#app").innerHTML = `${`\n<elm-priority-routes></elm-priority-routes>\n`}`