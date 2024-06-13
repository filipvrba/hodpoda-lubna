
import './packages/template-rjs-0.1.1/elements'
import './packages/gallery-rjs-0.1.0/elements'

import 'ElmHeader', './elements/elm_header'
window.custom_elements.define('elm-header', ElmHeader)

import 'ElmOpeningHours', './elements/elm_opening_hours'
window.custom_elements.define('elm-opening-hours', ElmOpeningHours)

import 'ElmMap', './elements/elm_map'
window.custom_elements.define('elm-map', ElmMap)

import 'ElmAdminLogin', './elements/elm_admin_login'
window.custom_elements.define('elm-admin-login', ElmAdminLogin)

import 'ElmAdmin', './elements/elm_admin'
window.custom_elements.define('elm-admin', ElmAdmin)

import 'ElmAdminDashboard', './elements/elm_admin_dashboard'
window.custom_elements.define('elm-admin-dashboard', ElmAdminDashboard)

import 'ElmAdminOpeningHours', './elements/elm_admin_opening_hours'
window.custom_elements.define('elm-admin-opening-hours', ElmAdminOpeningHours)

import 'ElmAlert', './elements/elm_alert'
window.custom_elements.define('elm-alert', ElmAlert)

import 'ElmAdminProfile', './elements/elm_admin_profile'
window.custom_elements.define('elm-admin-profile', ElmAdminProfile)
