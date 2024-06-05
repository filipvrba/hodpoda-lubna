import "../css/bootstrap.min.css";
import "../../node_modules/bootstrap-icons/font/bootstrap-icons.min.css";
import "../css/style.css";
import routesObj from "../json/routes.json";
import cellarGallery from "../json/cellar_gallery.json";
import megahateGallery from "../json/megahate_gallery.json";
import "./core";
import "./elements";
import "./pages";
window.ROUTES_JSON = routesObj;
const TITLE_APP = document.title;
window.TITLE_APP = TITLE_APP;

window.GALLERY_JSON = {
  "cellar-gallery": cellarGallery,
  "megahate-gallery": megahateGallery
};

window.ENVS = {GALLERY_CLICK: 0};
document.querySelector("#app").innerHTML = `${`\n<elm-priority-routes></elm-priority-routes>\n`}`