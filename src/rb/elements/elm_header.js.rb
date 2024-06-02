export default class ElmHeader < HTMLElement
  def initialize
    super
    
    @title = "Pivnice za KD"

    init_elm()

    window.header_hide = hide
  end

  def hide()
    Events.emit('#navbarSupportedContent', 'collapse.hide')
  end

  def init_elm()
    template = """
<nav class='navbar navbar-expand-lg'>
  <div class='container'>
    <a class='navbar-brand' href='#' onclick='headerHide()'>#{@title}</a>
    <button class='navbar-toggler' type='button' data-bs-toggle='collapse' data-bs-target='#navbarSupportedContent' aria-controls='navbarSupportedContent' aria-expanded='false' aria-label='Toggle navigation'>
      <span class='navbar-toggler-icon'></span>
    </button>

    <div class='collapse navbar-collapse' id='navbarSupportedContent'>
      <ul class='navbar-nav ml-auto'>
        <li class='nav-item'>
          <a class='nav-link' href='#galerie' onclick='headerHide()'>Galerie</a>
        </li>
      </ul>
    </div>
  </div>
</nav>
    """

    self.innerHTML = template
  end
end