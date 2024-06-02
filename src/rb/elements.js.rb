
import './packages/template-rjs-0.1.1/elements'
import './packages/gallery-rjs-0.1.0/elements'

import 'ElmHeader', './elements/elm_header'
window.custom_elements.define('elm-header', ElmHeader)

import 'ElmOpeningHours', './elements/elm_opening_hours'
window.custom_elements.define('elm-opening-hours', ElmOpeningHours)

import 'ElmMap', './elements/elm_map'
window.custom_elements.define('elm-map', ElmMap)
