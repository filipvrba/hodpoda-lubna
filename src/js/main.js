import "../css/bootstrap.min.css";
import "../css/style.css";
import routesObj from "../json/routes.json";
import galleryObj from "../json/gallery.json";
import "./core";
import "./elements";
import "./pages";
window.ROUTES_JSON = routesObj;
const TITLE_APP = document.title;
window.TITLE_APP = TITLE_APP;
window.GALLERY_JSON = galleryObj;
window.ENVS = {GALLERY_CLICK: 0};
document.querySelector("#app").innerHTML = `${`\n<elm-priority-routes></elm-priority-routes>\n`}`