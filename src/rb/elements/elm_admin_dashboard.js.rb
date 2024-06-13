export default class ElmAdminDashboard < HTMLElement
  PARAMETER = 'admin-index'

  def initialize
    super

    @h_tick = lambda { |e| update(e.detail.value) }

    init_elm()

    window.admin_dashboard_btn_click = button_click
  end

  def connected_callback()
    
  end

  def disconnected_callback()
  end

  def button_click(index)
    URLParams.set(PARAMETER, index)
  end

  def active_navs(index)
    param_index  = URLParams.get_index(PARAMETER)

    if index == param_index
      return {
        nav: 'active',
        content: 'active show'
      }
    else
      return {
        nav: '',
        content: ''
      }
    end
  end

  def init_elm()
    opening_hours_class = active_navs(0)
    profile_class = active_navs(1)

    template = """
<div class='col-md-8 mx-auto'>
  <elm-alert></elm-alert>

  <nav>
    <div class='nav nav-tabs mb-3 justify-content-center' id='nav-tab' role='tablist'>
      <button class='nav-link #{opening_hours_class.nav}' onclick='adminDashboardBtnClick(0)' id='nav-opening-hours-tab' data-bs-toggle='tab' data-bs-target='#nav-opening-hours' type='button' role='tab' aria-controls='nav-opening-hours' aria-selected='false' tabindex='-1'>Otevírací doba</button>
      <button class='nav-link #{profile_class.nav}' onclick='adminDashboardBtnClick(1)' id='nav-profile-tab' data-bs-toggle='tab' data-bs-target='#nav-profile' type='button' role='tab' aria-controls='nav-profile' aria-selected='false' tabindex='-1'>Profil</button>

    </div>
  </nav>
  <div class='tab-content' id='nav-tabContent'>
    <div class='tab-pane fade #{opening_hours_class.content} col-lg-8 mx-auto' id='nav-opening-hours' role='tabpanel' aria-labelledby='nav-opening-hours-tab'>
      <elm-admin-opening-hours></elm-admin-opening-hours>
    </div>
    <div class='tab-pane fade #{profile_class.content} col-lg-8 mx-auto' id='nav-profile' role='tabpanel' aria-labelledby='nav-profile-tab'>
      <elm-admin-profile></elm-admin-profile>
    </div>
  </div>
</div>
    """

    self.innerHTML = template
  end
end