import '../css/bootstrap.min.css'
import '../../node_modules/bootstrap-icons/font/bootstrap-icons.min.css'
import '../css/style.css'

import 'routesObj', '../json/routes.json'
import 'cellarGallery', '../json/cellar_gallery.json'
import 'megahateGallery', '../json/megahate_gallery.json'

import './core'
import './elements'
import './pages'

window.ROUTES_JSON = routes_obj
TITLE_APP = document.title
window.TITLE_APP = TITLE_APP
window.GALLERY_JSON = {
  "cellar-gallery" => cellar_gallery,
  "megahate-gallery" => megahate_gallery,
}
window.ENVS = {
  GALLERY_CLICK: 0,
}

document.querySelector('#app').innerHTML = """
<elm-priority-routes></elm-priority-routes>
"""
