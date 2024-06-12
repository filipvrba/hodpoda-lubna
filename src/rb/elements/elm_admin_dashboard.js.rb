export default class ElmAdminDashboard < HTMLElement
  def initialize
    super

    init_elm()
  end

  def connected_callback()
    
  end

  def disconnected_callback()
  end

  def init_elm()
    template = """
<div class='col-md-8 mx-auto'>
  <nav>
    <div class='nav nav-tabs mb-3 justify-content-center' id='nav-tab' role='tablist'>
      <button class='nav-link active' id='nav-opening-hours-tab' data-bs-toggle='tab' data-bs-target='#nav-opening-hours' type='button' role='tab' aria-controls='nav-opening-hours' aria-selected='false' tabindex='-1'>Otevírací doba</button>
    </div>
  </nav>
  <div class='tab-content' id='nav-tabContent'>
    <elm-admin-opening-hours></elm-admin-opening-hours>
  </div>
</div>
    """

    self.innerHTML = template
  end
end