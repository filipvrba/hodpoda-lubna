import "./packages/template-rjs-0.1.1/elements";
import "./packages/gallery-rjs-0.1.0/elements";
import ElmHeader from "./elements/elm_header";
window.customElements.define("elm-header", ElmHeader);
import ElmOpeningHours from "./elements/elm_opening_hours";
window.customElements.define("elm-opening-hours", ElmOpeningHours);
import ElmMap from "./elements/elm_map";
window.customElements.define("elm-map", ElmMap);
import ElmAdminLogin from "./elements/elm_admin_login";
window.customElements.define("elm-admin-login", ElmAdminLogin);
import ElmAdmin from "./elements/elm_admin";
window.customElements.define("elm-admin", ElmAdmin);
import ElmAdminDashboard from "./elements/elm_admin_dashboard";

window.customElements.define(
  "elm-admin-dashboard",
  ElmAdminDashboard
);

import ElmAdminOpeningHours from "./elements/elm_admin_opening_hours";

window.customElements.define(
  "elm-admin-opening-hours",
  ElmAdminOpeningHours
)