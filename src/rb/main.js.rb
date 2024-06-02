import '../css/bootstrap.min.css'
import '../css/style.css'
import 'routesObj', '../json/routes.json'
import 'galleryObj', '../json/gallery.json'

import './core'
import './elements'
import './pages'

window.ROUTES_JSON = routes_obj
TITLE_APP = document.title
window.TITLE_APP = TITLE_APP
window.GALLERY_JSON = gallery_obj
window.ENVS = {
  GALLERY_CLICK: 0,
}

document.querySelector('#app').innerHTML = """
<elm-priority-routes></elm-priority-routes>
"""
